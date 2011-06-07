# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{icss}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Philip (flip) Kromer for Infochimps"]
  s.date = %q{2011-06-07}
  s.description = %q{Infochimps Stupid Schema library: an avro-compatible data description standard. ICSS completely describes a collection of data (and associated assets) in a way that is expressive, scalable and sufficient to drive remarkably complex downstream processes.}
  s.email = %q{coders@infochimps.com}
  s.extra_rdoc_files = [
    "LICENSE.textile",
    "README.textile"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".watchr",
    "CHANGELOG.textile",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.textile",
    "README.textile",
    "Rakefile",
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
    "icss.gemspec",
    "icss_specification.textile",
    "init.rb",
    "lib/icss.rb",
    "lib/icss/brevity.rb",
    "lib/icss/code_asset.rb",
    "lib/icss/core_ext.rb",
    "lib/icss/data_asset.rb",
    "lib/icss/message.rb",
    "lib/icss/old.rb",
    "lib/icss/protocol.rb",
    "lib/icss/protocol_set.rb",
    "lib/icss/sample_message_call.rb",
    "lib/icss/target.rb",
    "lib/icss/type.rb",
    "lib/icss/type/factory.rb",
    "lib/icss/validations.rb",
    "lib/icss/view_helper.rb",
    "spec/icss_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/mrflip/icss}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{Infochimps Stupid Schema library: an avro-compatible data description standard. ICSS completely describes a collection of data (and associated assets) in a way that is expressive, scalable and sufficient to drive remarkably complex downstream processes.}
  s.test_files = [
    "spec/icss_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
      s.add_runtime_dependency(%q<gorillib>, ["~> 0.1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
      s.add_dependency(%q<gorillib>, ["~> 0.1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
    s.add_dependency(%q<gorillib>, ["~> 0.1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

