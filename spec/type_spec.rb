require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'icss/type'

module Icss
  module This
    module That
      class TheOther
      end
    end
  end
  Blinken = 7
end

describe Icss::Meta::Type do
  context '.fullname_for' do
    it 'converts from avro-style' do
      Icss::Meta::Type.fullname_for('a.b.c').should                           == 'a.b.c'
      Icss::Meta::Type.fullname_for('one_to.tha_three.to_tha_fo').should      == 'one_to.tha_three.to_tha_fo'
    end
    it 'converts from ruby-style' do
      Icss::Meta::Type.fullname_for('A::B::C').should                         == 'a.b.c'
      Icss::Meta::Type.fullname_for('OneTo::ThaThree::ToThaFo').should        == 'one_to.tha_three.to_tha_fo'
      Icss::Meta::Type.fullname_for('Icss::OneTo::ThaThree::ToThaFo').should  == 'one_to.tha_three.to_tha_fo'
      Icss::Meta::Type.fullname_for('::Icss::This::That::TheOther').should    == 'this.that.the_other'
    end
    it 'converts from class' do
      Icss::Meta::Type.fullname_for(Icss::This::That::TheOther).should        == 'this.that.the_other'
    end
  end
  context '.klassname_for' do
    it 'converts from avro-style' do
      Icss::Meta::Type.klassname_for('a.b.c').should                          == '::Icss::A::B::C'
      Icss::Meta::Type.klassname_for('one_to.tha_three.to_tha_fo').should     == '::Icss::OneTo::ThaThree::ToThaFo'
    end
    it 'converts from ruby-style' do
      Icss::Meta::Type.klassname_for('A::B::C').should                        == '::Icss::A::B::C'
      Icss::Meta::Type.klassname_for('OneTo.ThaThree.ToThaFo').should         == '::Icss::OneTo::ThaThree::ToThaFo'
      Icss::Meta::Type.klassname_for('Icss::OneTo::ThaThree::ToThaFo').should == '::Icss::OneTo::ThaThree::ToThaFo'
      Icss::Meta::Type.klassname_for('::Icss::This::That::TheOther').should   == '::Icss::This::That::TheOther'
    end
    it 'converts from class' do
      Icss::Meta::Type.klassname_for(Icss::This::That::TheOther).should       == '::Icss::This::That::TheOther'
    end
  end
end

