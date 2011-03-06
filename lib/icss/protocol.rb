module Icss

  #
  # Describes an Avro Protocol Declaration
  #
  # Avro protocols describe RPC interfaces. The Protocol class will receive an
  # Avro JSON
  #
  # A Protocol has the following attributes:
  #
  # * protocol, a string, the name of the protocol (required). +name+ is
  #   provided as an alias for +protocol+.
  #
  # * namespace, a string that qualifies the name (optional).
  #
  # * doc, a string describing this protocol (optional).
  #
  # * types, an optional list of definitions of named types (records, enums,
  #   fixed and errors). An error definition is just like a record definition
  #   except it uses "error" instead of "record". Note that forward references
  #   to named types are not permitted.
  #
  # * messages, an optional JSON object whose keys are message names and whose
  #   values are objects whose attributes are described below. No two messages
  #   may have the same name.
  #
  # The name and namespace qualification rules defined for schema objects apply
  # to protocols as well: see the documentation for Icss::Type.
  #
  # For example, one may define a simple HelloWorld protocol with:
  #
  #     {
  #       "namespace":    "com.acme",
  #       "protocol":     "HelloWorld",
  #       "doc":          "Protocol Greetings",
  #       "types": [
  #         { "name":     "Greeting",
  #           "type":     "record",
  #           "fields":   [ {"name": "message", "type": "string"} ]},
  #         { "name":     "Curse",
  #           "type":     "error",
  #           "fields":   [ {"name": "message", "type": "string"} ]}
  #       ],
  #       "messages": {
  #         "hello": {
  #           "doc":      "Say hello.",
  #           "request":  [{"name": "greeting", "type": "Greeting" }],
  #           "response": "Greeting",
  #           "errors":   ["Curse"]
  #         }
  #       }
  #     }
  #
  class Protocol
    include Receiver
    include Icss::Validations

    rcvr_accessor :protocol,    String, :required => true
    alias_method  :name, :protocol
    rcvr_accessor :namespace,   String # must be *dotted* ("foo.bar"), not slashed ("foo/bar")
    rcvr_accessor :doc,         String
    #
    rcvr_accessor :types,       Array, :of => Icss::TypeFactory
    rcvr_accessor :messages,    Hash,  :of => Icss::Message
    # extensions to avro
    rcvr_accessor :data_assets, Array, :of => Icss::DataAsset
    rcvr_accessor :code_assets, Array, :of => Icss::CodeAsset
    rcvr_accessor :targets,     Hash,  :of => Icss::TargetListFactory

    # attr_accessor :body
    def after_receive hsh
      # Set each message's protocol to self, and if the name wasn't given, set
      # it using the message's hash key.
      self.messages.each{|msg_name, msg| msg.protocol = self; msg.name ||= msg_name } if self.messages
      # Set all the type's parent to self (for namespace resolution)
      self.types.each{|type| type.parent  = self } if self.types
      validate_name
      validate_namespace
    end

    # String: namespace.name
    def fullname
      [namespace, name].compact.join(".")
    end

    def path
      fullname.gsub('.', '/')
    end

    def receive_targets hsh
      self.targets = hsh.inject({}) do |target_obj_hsh, (target_name, target_info_list)|
        target_obj_hsh[target_name] = TargetListFactory.receive(target_name, target_info_list) # returns an arry of targets
        target_obj_hsh
      end
    end

    def to_hash()
      {
        :namespace   => @namespace, # use accessor so unset namespace isn't given
        :protocol    => protocol,
        :doc         => doc,
        :types       => (types       && types.map(&:to_hash)),
        :messages    => (messages   ||{}).inject({}){|h,(k,v)| h[k] = v.to_hash; h },
        :data_assets => (data_assets && data_assets.map(&:to_hash)),
        :code_assets => (code_assets && code_assets.map(&:to_hash)),
        :targets     => (targets     && targets.inject({}){|h,(k,v)| h[k] = v.to_hash; h }),
      }.reject{|k,v| v.nil? }
    end

    # This will cause funny errors when it is an element of something that's to_json'ed
    def to_json() to_hash.to_json ; end
  end
end
