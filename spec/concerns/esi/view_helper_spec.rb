require File.dirname(__FILE__) + '/../../spec_helper'

describe Esi::ViewHelper do
  include ActionView::Helpers::TagHelper
  
  describe "adding an <esi:include> element with a URL" do
    
    it "should use the URI as the src attribute" do
      esi_include("/dingo").should == %{<esi:include src="/dingo" />}
    end
    
    it "should allow the specification of :alt and :onerror attributes" do
      esi_include(
        "/dingo",
        :alt => "/woot", :onerror => "continue"
      ).should == %{<esi:include alt="/woot" onerror="continue" src="/dingo" />}
    end
    
  end
  
  describe "adding an <esi:include> element with a #url_for hash" do
    
    before(:each) do
      self.stub!(:url_for).and_return("/dingo")
    end
    
    it "should use the built URI as the src attribute" do
      self.should_receive(:url_for).with(
        :controller => "bears",
        :action => "attack",
        :only_path => false
      ).and_return("/dingo")
      
      esi_include(
        :controller => "bears",
        :action => "attack"
      ).should == %{<esi:include src="/dingo" />}
    end
    
    it "should allow the specification of :alt and :onerror attributes" do
      esi_include(
        { :blah => "whee" },
        { :alt => "/woot", :onerror => "continue" }
      ).should == %{<esi:include alt="/woot" onerror="continue" src="/dingo" />}
    end
    
  end
  
end
