require 'yaml'
require 'json' unless defined?(JSON)

module Icss
  module ReceiverModel

    #
    # adds methods to load and store from json, yaml or magic
    #
    # This will require 'json' UNLESS you have already included something (so if
    # you want to say require 'yajl/json_gem' then do that first).
    #
    module ActsAsLoadable
      module ClassMethods

        # module ::Icss::ReceiverModel::ClassMethods
        #   include Icss::ReceiverModel::ActsAsLoadable::ClassMethods
        # end

        def receive_json stream
          receive(JSON.load(stream))
        end

        def receive_yaml stream
          receive(YAML.load(stream))
        end

        #
        # The file is loaded with
        # * YAML if the filename ends in .yaml or .yml
        # * JSON otherwise
        #
        def receive_from_file filename
          stream = File.open(filename, 'r:utf-8')
          (filename =~ /.ya?ml$/) ? receive_yaml(stream) : receive_json(stream)
          
        rescue 
          raise $!, "Error loading file (#{filename}): #{$!}", $!.backtrace
        end
      end

      def merge_from_file! filename
        other_obj = self.class.receive_from_file(filename)
        tree_merge! other_obj
      end
    end
    
  end

end