module Icss
  module Meta

    module TypeFactory
      def self.receive(*args)
        super(*args)
      end
    end

    # -------------------------------------------------------------------------
    #
    # Container Types (array, map and union)
    #

    #
    # ArrayType describes an Avro Array type.
    #
    # Arrays use the type name "array" and support a single attribute:
    #
    # * items: the schema of the array's items.
    #
    # @example, an array of strings is declared with:
    #
    #     {"type": "array", "items": "string"}
    #
    module ArrayType
      module Schema
        include Icss::Meta::Type::Schema
        has_field_writers
        field :type,  String, :validates => { :format => { :with => /^array$/ } }
        field :items, Icss::Meta::TypeFactory
        #
        def to_schema() super.merge({ :type => :array, :items => self.items })  end
      end
      def self.included(base) base.extend(Schema) end
      #
      def self.receive(schema)
        schema.symbolize_keys!
        type  = schema[:type]
        warn "Illegal type '#{type}' in #{self} schema: should be 'array'" unless (type && (type.to_sym == :array))
        items = schema[:items]
        #
        if items.respond_to?(:to_sym) then
          items = items.to_sym
          type_appendage = Icss::Meta::Type.klassname_for(items).gsub(/^:*Icss:+/, '').gsub(/:+/, '_')
          klass = Icss::Meta::NamedType.get_type_klass([], "ArrayOf#{type_appendage}", Array)
        else
          klass = Class.new(Array)
        end
        #
        klass.class_eval{ include(::Icss::Meta::ArrayType) }
        klass.items = items
        klass
      end
    end

    #
    # HashType describes an Avro Map type (which corresponds to a Ruby
    # Hash). HashType is a synonym for HashType.
    #
    # Maps use the type name "map" and support one attribute:
    #
    # * values: the schema of the map's values. Avro Map keys are assumed to be strings.
    #
    # @example, a map from string to long is declared with:
    #
    #     {"type": "map", "values": "long"}
    #
    module HashType
      module Schema
        include Icss::Meta::Type::Schema
        has_field_writers
        def to_schema() super.merge({ :type => :map, :values => self.values })  end
        #
        field :type,   String, :validates => { :format => { :with => /^map$/ } }
        field :values, Icss::Meta::TypeFactory, :required => true
      end
      def self.included(base) base.extend(Schema) end
      #
      def self.receive(schema)
        schema.symbolize_keys!
        type  = schema[:type]
        warn "Illegal type '#{type}' in #{self} schema: should be 'map'" unless (type && (type.to_sym == :map))
        values = schema[:values]
        #
        if values.respond_to?(:to_sym) then
          values = values.to_sym
          type_appendage = Icss::Meta::Type.klassname_for(values).gsub(/^:*Icss:+/, '').gsub(/:+/, '_')
          klass = Icss::Meta::NamedType.get_type_klass([], "HashOf#{type_appendage}", Hash)
        else
          klass = Class.new(Hash)
        end
        #
        klass.class_eval{ include(::Icss::Meta::HashType) }
        klass.values = values
        klass
      end
      #
      def initialize(*args, &block)
        if args.length == 1 && args.first.respond_to?(:each_pair)
          hsh = args.pop
        end
        super(*args, &block)
        self.merge!(hsh) if hsh
      end
    end

    # #
    # # Describes an Avro Union type.
    # #
    # # Unions are represented using JSON arrays. For example, ["string", "null"]
    # # declares a schema which may be either a string or null.
    # #
    # # Unions may not contain more than one schema with the same type, except for
    # # the named types record, fixed and enum. For example, unions containing two
    # # array types or two map types are not permitted, but two types with different
    # # names are permitted. (Names permit efficient resolution when reading and
    # # writing unions.)
    # #
    # # Unions may not immediately contain other unions.
    # #
    # class UnionType
    #   extend Icss::Meta::ContainerType
    #   #
    #   attr_accessor :embedded_types
    #   attr_accessor :declaration_flavors
    #   #
    #   def receive! type_list
    #     self.declaration_flavors = []
    #     self.embedded_types = type_list.map do |schema|
    #       type = TypeFactory.receive(schema)
    #       declaration_flavors << TypeFactory.classify_schema_declaration(schema)
    #       type
    #     end
    #   end
    #   def to_schema
    #     embedded_types.zip(declaration_flavors).map do |t,fl|
    #       [:named_type].include?(fl) ? t.name : t.to_schema
    #     end
    #   end
    # end
    #
    # unless defined?(CONTAINER_TYPES)
    #   ::Icss::CONTAINER_TYPES = {
    #     :map     => Icss::HashType,
    #     :array   => Icss::ArrayType,
    #     :union   => Icss::UnionType,
    #   }.freeze
    # end

    # module ErrorType
    #   include RecordType
    # end

    # #
    # def doc() "" end
    # def doc=(str)
    #   singleton_class.class_eval do
    #     remove_possible_method(:doc)
    #     define_method(:doc){ str }
    #   end
    # end

    # #
    # # Describes an Avro Enum type.
    # #
    # # Enums use the type name "enum" and support the following attributes:
    # #
    # # name:       a string providing the name of the enum (required).
    # # namespace:  a string that qualifies the name;
    # # doc:        a string providing documentation to the user of this schema (optional).
    # # symbols:    an array, listing symbols, as strings or ruby symbols (required). All
    # #             symbols in an enum must be unique; duplicates are prohibited.
    # #
    # # For example, playing card suits might be defined with:
    # #
    # # { "type": "enum",
    # #   "name": "Suit",
    # #   "symbols" : ["SPADES", "HEARTS", "DIAMONDS", "CLUBS"]
    # # }
    # #
    # class EnumType
    #   include Icss::Meta::NamedType
    #   extend  RecordType::FieldDecorators
    #   #
    #   field :symbols, Array, :of => String, :required => true, :default => []
    #   def to_schema
    #     (defined?(super) ? super : {}).merge({ :symbols   => symbols })
    #   end
    # end
    #
    # #
    # # Describes an Avro Fixed type.
    # #
    # # Fixed uses the type name "fixed" and supports the attributes:
    # #
    # # * name: a string naming this fixed (required).
    # # * namespace, a string that qualifies the name;
    # # * size: an integer, specifying the number of bytes per value (required).
    # #
    # #   For example, 16-byte quantity may be declared with:
    # #
    # #     {"type": "fixed", "size": 16, "name": "md5"}
    # #
    # class FixedType < String
    #   include Icss::Meta::NamedType
    #   extend  RecordType::FieldDecorators
    #   #
    #   field :size, Integer, :required => true
    #   def to_schema
    #     (defined?(super) ? super : {}).merge( :size => size )
    #   end
    # end

    # unless defined?(NAMED_TYPES)
    #   ::Icss::NAMED_TYPES      = {
    #     :fixed   => Icss::FixedType,
    #     :enum    => Icss::EnumType,
    #     :record  => Icss::RecordType,
    #     :error   => Icss::ErrorType
    #   }.freeze
    # end
  end

end
