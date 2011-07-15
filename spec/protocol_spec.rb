require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'icss'

describe Icss::Protocol do
  let(:simple_icss) do
    Icss::Protocol.receive_from_file(ICSS_ROOT_DIR('examples/chronic.icss.yaml'))
  end

  it 'loads cleanly' do
    simple_icss.name.should == 'chronic'
    simple_icss.fullname.should == 'util.time.chronic'
  end

  describe '#fullname' do
    it 'has namespace and name' do
      simple_icss.fullname.should == 'util.time.chronic'
      simple_icss.namespace = nil
      simple_icss.fullname.should == 'chronic'
    end
  end
  describe '#path' do
    it 'is a / separated version of the name, with no / at start' do
      simple_icss.path.should == 'util/time/chronic'
    end
  end
  describe '#doc' do
    it 'takes a doc string' do
      simple_icss.doc.should == 'A series of calls hooking into the Chronic ruby gem'
    end
  end

  describe 'types' do
    it 'has an array of types' do
      simple_icss.types.map(&:name).should == ['chronic_parse_params', 'chronic_parse_response']
    end
  end

  describe 'messages' do
    it 'has a hash of messages' do
      simple_icss.messages.keys.should == ['parse']
    end

    it 'named each message for its key' do
      simple_icss.messages['parse'].name.should == 'parse'
      simple_icss.receive!({ :messages => { 'foo' => { :request => [] } }})
      simple_icss.messages['foo'].name.should == 'foo'
    end

    it '#find_message' do
      msg = simple_icss.find_message(:parse)
      msg.should be_a(Icss::Message) ; msg.name.should == 'parse'
      msg = simple_icss.find_message('util.time.parse')
      msg.should be_a(Icss::Message) ; msg.name.should == 'parse'
      msg = simple_icss.find_message('util/time/parse')
      msg.should be_a(Icss::Message) ; msg.name.should == 'parse'
    end
  end

  describe 'targets' do
    it 'has a hash of targets' do
      simple_icss.targets.keys.should == ['catalog']
      simple_icss.targets['catalog'].first.should be_a(Icss::CatalogTarget)
      simple_icss.targets['catalog'].first.name.should == 'util_time_chronic_parse'
    end
  end

  # describe 'tree_merge!' do
  #   it 'merges recursively'
  # end

  describe 'validations' do
    it 'validates protocol name' do
      simple_icss.should be_valid
      simple_icss.protocol = '' ;    simple_icss.should_not be_valid ; simple_icss.errors[:protocol].should == ["can't be blank"]
      simple_icss.protocol = '1bz' ; simple_icss.should_not be_valid ; simple_icss.errors[:protocol].should == ["must start with [A-Za-z_] and contain only [A-Za-z0-9_]."]
    end

    it 'validates namespace' do
      simple_icss.should be_valid
      simple_icss.namespace = '' ;    simple_icss.should_not be_valid ; simple_icss.errors[:namespace].should == ["can't be blank"]
      simple_icss.namespace = '1bz' ; simple_icss.should_not be_valid ; simple_icss.errors[:namespace].first.should =~ /must be a dot-s/
    end
  end

  describe '#to_hash' do
    it 'roundtrips' do
      hsh = simple_icss.to_hash
      hsh.should == {
        :namespace=>"util.time", :protocol=>"chronic",
        :doc=>"A series of calls hooking into the Chronic ruby gem",
        :types => [
          {:name=>"chronic_parse_params",   :doc=>"Query API parameters for the /util/time/chronic/parse call", :type=>:record,
            :fields=>[
              {:name=>"time_str", :type=>:string, :doc=>"The string to parse."},
              {:name=>"context", :type=>:symbol, :doc=>"<tt>past</tt> or <tt>future</tt> (defaults to <tt>future</tt>)\nIf your string represents a birthday, you can set <tt>context</tt> to <tt>past</tt> and if an ambiguous string is given, it will assume it is in the past. Specify <tt>future</tt> or omit to set a future context."},
              {:name=>"now", :type=>:time, :doc=>"Time (defaults to Time.now)\nBy setting <tt>:now</tt> to a Time, all computations will be based off of that time instead of Time.now. If set to nil, Chronic will use the current time in UTC. You must supply a date that unambiguously parses with the much-less-generous ruby Time.parse()"},
              {:name=>"ambiguous_time_range", :type=>:int, :doc=>"Integer or <tt>:none</tt> (defaults to <tt>6</tt> (6am-6pm))\nIf an Integer is given, ambiguous times (like 5:00) will be assumed to be within the range of that time in the AM to that time in the PM. For example, if you set it to <tt>7</tt>, then the parser will look for the time between 7am and 7pm. In the case of 5:00, it would assume that means 5:00pm. If <tt>:none</tt> is given, no assumption will be made, and the first matching instance of that time will be used."}
            ]},
          {:name=>"chronic_parse_response", :doc=>"Query API response for the /util/time/chronic/parse call",   :type=>:record,
            :fields=>[
              {:name=>"time", :type=>:string, :doc=>"The UTC parsed time, as a \"ISO 8601 combined date time\":http://en.wikipedia.org/wiki/ISO_8601 string."},
              {:name=>"epoch_seconds", :type=>:int, :doc=>"The UTC parsed time, as \"epoch seconds\":http://en.wikipedia.org/wiki/Epoch_seconds integer."}
            ]}
        ],
        :messages => {
          'parse' => {:doc=>"\nChronic is a natural language date/time parser written in pure Ruby. See below\nfor the wide variety of formats Chronic will parse.", :request=>[{:name=>"chronic_parse_params", :type=>"chronic_parse_params"}], :response=>"chronic_parse_response", :samples=>[{:request=>[{"time_str"=>"one hour ago", "now"=>"2007-03-16T12:09:08Z"}], :response=>{"epoch_seconds"=>1174043348, "time"=>"2007-03-16T11:09:08Z"}, :url=>"?now=2007-03-16T12%3A09%3A08Z&time_str=one%20hour%20ago"}, {:request=>[{"time_str"=>"Yesterday", "now"=>"5:06:07T2010-08-08Z"}], :response=>{"epoch_seconds"=>1281182400, "time"=>"2010-08-07T12:00:00Z"}, :url=>"?now=5%3A06%3A07%202010-08-08&time_str=Yesterday"}, {:url=>"?time_str=5pm+on+November+4th&context=past"}]},
        },
        :data_assets=>[],
        :code_assets=>[{:location=>"code/chronic_endpoint.rb"}],
        :targets => {"catalog"=>[{:name=>"util_time_chronic_parse", :title=>"Utils - Parse Times", :description=>"An API call to parse human-readable date / time strings", :tags=>["apiawesome", "ruby", "gems", "chronic", "time", "date", "util", "parse"], :messages=>["parse"]}]},
      }
    end
  end

end

