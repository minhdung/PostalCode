# postal spec
require 'spec_helper'

describe PostalCode::Postal do
  before {@postal = PostalCode::Postal.new}
  subject {@postal}

  it {should respond_to(:jis_code)}
  it {should respond_to(:former_post_code)}
  it {should respond_to(:post_code)}
  it {should respond_to(:province_kana)}
  it {should respond_to(:city_kana)}
  it {should respond_to(:town_kana)}
  it {should respond_to(:province_kanji)}
  it {should respond_to(:city_kanji)}
  it {should respond_to(:town_kanji)}
  it {should respond_to(:plural_code)}
  it {should respond_to(:unknown)}
  it {should respond_to(:district_of_a_town)}
  it {should respond_to(:plural_town)}
  it {should respond_to(:update)}
  it {should respond_to(:update_reason)}

    before {@postal = PostalCode::Postal.new(jis_code: "123123",
                                             former_post_code: "252",
                                             post_code: "2520815",
                                             province_kana: "province",
                                             city_kana: "city",
                                             town_kana: "town",
                                             province_kanji: "province",
                                             city_kanji: "city",
                                             town_kanji: "town",
                                             plural_code: 0,
                                             unknown: 0,
                                             district_of_a_town: 0,
                                             plural_town: 0,
                                             update: 0,
                                             update_reason: 0)}

  describe "#match_conditions" do

    context "match condition" do
      let(:conditions){ {post_code: "2520815", province_kana: "province"} }
      it {@postal.match_conditions?(conditions).should == true}
    end

    context "not match condition" do
      let(:conditions){ {post_code: "2342342"} }
      it {@postal.match_conditions?(conditions).should == false}
    end
    
    context "error params" do
      let(:conditions){ {asdf: "asdf"} }
      it {@postal.match_conditions?(conditions).should == false}
    end

  end

  describe "#match_post_code" do

    context "match post code" do
      let(:code){ "2520815" }
      it {@postal.match_post_code?(code).should == true}
    end

    context "not match post code" do
      let(:code){ "2520817" }
      it {@postal.match_post_code?(code).should == false}
    end

  end

  describe "#match_address" do
    
    context "invalid param" do
      context "no params" do
        it "raise error" do 
          expect {@postal.match_address?}.to raise_error(ArgumentError)
        end
      end
      
      context "too much params" do
        it "raise error" do
          expect {@postal.match_address?(1,2,3,4,5)}.to raise_error(ArgumentError)
        end
      end
    end

    context "one param" do
      
      context "match address" do
        let(:address){ "city" }
        it {@postal.match_address?(address).should == true}
      end
      
      context "not match address" do
        let(:address){ "adsfasfd" }
        it {@postal.match_address?(address).should == false}
      end
      
    end
    
    context "two param" do
      
      context "match" do
        let(:first){"province"}
        let(:last){"city"}
        it {@postal.match_address?(first, last).should == true}
      end
      
      context "not match" do
        let(:first){"invalid_province"}
        let(:last){"cit"}
        it {@postal.match_address?(first, last).should == false}
      end
      
    end
    
    context "three param" do
      context "match" do
        let(:province){"province"}
        let(:city){"city"}
        let(:town){"town"}
        it{@postal.match_address?(province, city, town).should == true}
      end
      
      context "not match" do
        let(:province){"province"}
        let(:city){"invalid_city"}
        let(:town){"town"}
        it{@postal.match_address?(province, city, town).should == false}
      end
    end
  end
end
