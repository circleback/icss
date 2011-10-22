# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "icss"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Philip (flip) Kromer for Infochimps"]
  s.date = "2011-10-22"
  s.description = "Infochimps Simple Schema library: an avro-compatible data description standard. ICSS completely describes a collection of data (and associated assets) in a way that is expressive, scalable and sufficient to drive remarkably complex downstream processes."
  s.email = "coders@infochimps.com"
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".document",
    ".gitignore",
    ".rspec",
    ".watchr",
    "CHANGELOG.md",
    "Gemfile",
    "LICENSE.textile",
    "README.md",
    "Rakefile",
    "TODO.md",
    "VERSION",
    "examples/avro_examples/BulkData.avpr",
    "examples/avro_examples/complicated.icss.yaml",
    "examples/avro_examples/interop.avsc",
    "examples/avro_examples/mail.avpr",
    "examples/avro_examples/namespace.avpr",
    "examples/avro_examples/org/apache/avro/ipc/HandshakeRequest.avsc",
    "examples/avro_examples/org/apache/avro/ipc/HandshakeResponse.avsc",
    "examples/avro_examples/org/apache/avro/ipc/trace/avroTrace.avdl",
    "examples/avro_examples/org/apache/avro/ipc/trace/avroTrace.avpr",
    "examples/avro_examples/org/apache/avro/mapred/tether/InputProtocol.avpr",
    "examples/avro_examples/org/apache/avro/mapred/tether/OutputProtocol.avpr",
    "examples/avro_examples/simple.avpr",
    "examples/avro_examples/weather.avsc",
    "examples/bnc.icss.yaml",
    "examples/chronic.icss.yaml",
    "examples/test_icss.yaml",
    "icss.gemspec",
    "icss_specification.textile",
    "init.rb",
    "lib/icss.rb",
    "lib/icss/core_types.rb",
    "lib/icss/error.rb",
    "lib/icss/message.rb",
    "lib/icss/message/message_sample.rb",
    "lib/icss/protocol.rb",
    "lib/icss/protocol/code_asset.rb",
    "lib/icss/protocol/data_asset.rb",
    "lib/icss/protocol/target.rb",
    "lib/icss/receiver_model.rb",
    "lib/icss/receiver_model/active_model_shim.rb",
    "lib/icss/receiver_model/acts_as_hash.rb",
    "lib/icss/receiver_model/acts_as_loadable.rb",
    "lib/icss/receiver_model/acts_as_tuple.rb",
    "lib/icss/receiver_model/locale/en.yml",
    "lib/icss/receiver_model/to_geo_json.rb",
    "lib/icss/receiver_model/tree_merge.rb",
    "lib/icss/receiver_model/validations.rb",
    "lib/icss/serialization.rb",
    "lib/icss/serialization/zaml.rb",
    "lib/icss/type.rb",
    "lib/icss/type/base_type.rb",
    "lib/icss/type/named_type.rb",
    "lib/icss/type/record_field.rb",
    "lib/icss/type/record_model.rb",
    "lib/icss/type/record_schema.rb",
    "lib/icss/type/record_type.rb",
    "lib/icss/type/simple_types.rb",
    "lib/icss/type/structured_schema.rb",
    "lib/icss/type/type_factory.rb",
    "lib/icss/type/union_schema.rb",
    "lib/icss/view_helper.rb",
    "notes/named_array.md",
    "notes/on_include_vs_extend_etc.rb",
    "notes/technical_details.md",
    "spec/core_types_spec.rb",
    "spec/fixtures/zaml_complex_hash.yaml",
    "spec/icss_spec.rb",
    "spec/message/message_sample_spec.rb",
    "spec/message_spec.rb",
    "spec/protocol/protocol_validations_spec.rb",
    "spec/protocol_spec.rb",
    "spec/receiver_model_spec.rb",
    "spec/serialization/zaml_spec.rb",
    "spec/serialization/zaml_test.rb",
    "spec/serialization_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/icss_test_helper.rb",
    "spec/support/load_example_protocols.rb",
    "spec/type/base_type_spec.rb",
    "spec/type/named_type_spec.rb",
    "spec/type/record_field_spec.rb",
    "spec/type/record_model_spec.rb",
    "spec/type/record_schema_spec.rb",
    "spec/type/record_type_spec.rb",
    "spec/type/simple_types_spec.rb",
    "spec/type/structured_schema_spec.rb",
    "spec/type/type_factory_spec.rb",
    "spec/type/union_schema_spec.rb",
    "spec/type_spec.rb"
  ]
  s.homepage = "http://github.com/mrflip/icss"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Infochimps Simple Schema library: an avro-compatible data description standard. ICSS completely describes a collection of data (and associated assets) in a way that is expressive, scalable and sufficient to drive remarkably complex downstream processes."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<activemodel>, ["~> 3.0.9"])
      s.add_runtime_dependency(%q<addressable>, ["~> 2.2"])
      s.add_runtime_dependency(%q<configliere>, ["~> 0.4.8"])
      s.add_runtime_dependency(%q<gorillib>, [">= 0"])
      s.add_development_dependency(%q<awesome_print>, ["~> 0.4.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<activemodel>, ["~> 3.0.9"])
      s.add_dependency(%q<addressable>, ["~> 2.2"])
      s.add_dependency(%q<configliere>, ["~> 0.4.8"])
      s.add_dependency(%q<gorillib>, [">= 0"])
      s.add_dependency(%q<awesome_print>, ["~> 0.4.0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<activemodel>, ["~> 3.0.9"])
    s.add_dependency(%q<addressable>, ["~> 2.2"])
    s.add_dependency(%q<configliere>, ["~> 0.4.8"])
    s.add_dependency(%q<gorillib>, [">= 0"])
    s.add_dependency(%q<awesome_print>, ["~> 0.4.0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

