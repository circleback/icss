module Icss
  module Meta

    class RecordSchema
      include Icss::Meta::RecordModel
      include Icss::ReceiverModel::ActsAsHash
      include Gorillib::Hashlike
      include Gorillib::Hashlike::Keys
      field :fullname,         Symbol, :required => true
      alias_method :receive_name, :receive_fullname
      field :type,             Symbol, :required => true
      field :is_a,             :array, :default => [], :items => Icss::Meta::TypeFactory
      field :_domain_id_field, String, :default => 'name'
      #
      field :doc,              String, :required => true
      field :fields,           :array, :default => [], :items => Object # , :items => Icss::Meta::RecordField
      attr_accessor :model_klass
      attr_accessor :model_superklass

      def self.get_klass_name(schema)
        schema[:name]
      end

      def self.receive(schema, default_superklass=Object)
        schema_obj = super(schema)
        schema_obj.fullname ||= get_klass_name(schema)
        schema_obj.is_a = [default_superklass] if schema_obj.is_a.empty? && (default_superklass != Object)
        #
        model_klass = Icss::Meta::NamedType.get_model_klass(schema_obj.fullname, (schema_obj.parent_klass||Object))
        #
        model_klass.class_eval do
          include(::Icss::Meta::RecordModel)
        end
        #
        schema_obj.decorate_with_superclass_models(model_klass)
        #
        schema_obj.inscribe_schema(model_klass)
        model_klass
      end

      def parent_klass()      is_a.first ; end
      def parent_metamodels()
        return [] if is_a.length <= 1
        is_a[1 .. -1].map{|pk| pk.metamodel if pk.respond_to?(:metamodel) }.compact
      end

      def decorate_with_superclass_models(model_klass)
        parent_metamodels.each do |parent_metamodel|
          model_klass.class_eval{ include parent_metamodel }
        end
      end

      def inscribe_schema(model_klass)
        schema_writer = self
        model_type = model_klass.singleton_class
        model_type.class_eval{ define_method(:_schema){ schema_writer } }
        #
        [:doc, :fullname, :is_a, :_domain_id_field
        ].each do |attr|
          val = self.send(attr)
          model_type.class_eval{ define_method(attr){ val } }
        end
        inscribe_fields(model_klass)
      end

      def inscribe_fields(model_klass)
        self.fields.each do |field_schema|
          model_klass.field(field_schema[:name], field_schema[:type], field_schema)
        end
      end

      def receive_fields(flds)
        super(flds.map(&:symbolize_keys!))
      end

      def inscribe_is_a(model_klass)

      end
    end

    class ErrorSchema
      include Icss::Meta::RecordType
    end
    module ErrorModel
    end

  end
end
