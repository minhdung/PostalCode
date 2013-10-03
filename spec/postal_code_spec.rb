# -*- coding: utf-8 -*-
require 'spec_helper'

describe PostalCode::JapanPostal do
  before {@jpostal = PostalCode::JapanPostal.instance}
  subject(){@jpostal}

  it{ should respond_to(:detect)}

  context "import csv success" do
    subject {@jpostal.postals.is_a?(Array)}
    it {should == true}
  end

  describe "#detect" do
    subject {@jpostal.detect(former_post_code: "066").length}
    it {should_not == 0}
  end

  describe ".where" do
    subject {PostalCode::JapanPostal.where(former_post_code: "252").length}
    it {should_not == 0}
  end

  describe "#first" do
    it {@jpostal.first.should == @jpostal.postals.first}
  end

  describe "#last" do
    it {@jpostal.last.should == @jpostal.postals.last}
  end
  
  describe "#object_at" do

    context "one of argument" do
      it {@jpostal.object_at(0).should_not nil}
    end

    context "two of argument" do
      it {@jpostal.object_at(0, 2).length.should == 2}
    end
    
    context "argument is range" do
      it {@jpostal.object_at(1..10).length.should == 10}
    end

    context "invalid integer argument" do
      it {@jpostal.object_at("0").should == nil}
    end
    
    context "invalid number of arrgument" do
      it {@jpostal.object_at(1,2,3,4).should == nil}
    end
    
  end
  
  describe ".all" do
    before {@postals = PostalCode::JapanPostal.all}
    it {@postals.is_a?(Array).should == true}
  end

  describe ".find_with_code" do
    context "correct code" do
      before {@results = PostalCode::JapanPostal.find_with_code("2520815")}
      it {@results.length.should_not == 0}
    end
    context "incorrect code" do
      before {@results = PostalCode::JapanPostal.find_with_code("123123")}
      it {@results.length.should == 0}
    end
  end

  describe ".find_with_address" do
    let(:address1){"神奈川"}
    let(:address2){"藤沢"}
    let(:address3){"石川"}

    let(:invalid_address1){"神奈川invalid"}
    let(:invalid_address2){"藤沢invalid"}
    let(:invalid_address3){"石川invalid"}
    
    context "one params" do
      context "correct address" do
        before {@results = PostalCode::JapanPostal.find_with_address(address1)}
        it {@results.length.should_not == 0}
      end
      context "incorrect address" do
        before {@results = PostalCode::JapanPostal.find_with_address(invalid_address1)}
        it {@results.length.should == 0}
      end
    end

    context "two params" do
      context "correct address" do
        before {@results = PostalCode::JapanPostal.find_with_address(address1, address2)}
        it {@results.length.should_not == 0}
      end
      context "incorrect address" do
        before {@results = PostalCode::JapanPostal.find_with_address(invalid_address1,
                                                                     invalid_address2)}
        it {@results.length.should == 0}
      end
    end

    context "three params" do
      context "correct address" do
        before{@results = PostalCode::JapanPostal.find_with_address(address1, address2, address3)}
        it {@results.length.should_not == 0}
      end
      context "incorrect address" do
        before{@results = PostalCode::JapanPostal.find_with_address(invalid_address1, 
                                                                    invalid_address2,
                                                                    invalid_address3)}
        it {@results.length.should == 0}
      end
    end
    
  end

end
