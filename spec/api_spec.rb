# encoding: utf-8
require 'spec_helper.rb'

FakeWeb.register_uri(
  :get,
  "http://tx3.travian.com.br",
  :body => "./spec/fakeweb_pages/brx_login.html",
  :content_type => "text/html"
)

FakeWeb.register_uri(
  :post,
  "http://tx3.travian.com.br/dorf1.php",
  :body => "./spec/fakeweb_pages/brx_dorf1.html",
  :content_type => "text/html"
)

FakeWeb.register_uri(
  :get,
  "http://tx3.travian.com.br/dorf3.php",
  :body => "./spec/fakeweb_pages/brx_dorf3.html",
  :content_type => "text/html"
)

module Travian
  describe API do
    describe '.villages' do
      it 'returns an array' do
        Travian.villages.should be_an Array
      end

      it 'should be an array with village objects' do
        Travian.villages.all? {|v| v.is_a? Village }.should be true
      end
    end

    describe '.village' do
      it 'should return a village' do
        Travian.village("al").should be_a Village
      end
    end

    describe '.villages_by_name' do
      context 'when passed "al" as the search term' do
        before :all do
          @villages = [
            Village.new('Almancil', 67924),
            Village.new('São Brás de Alportel', 59519),
          ]
        end

        it 'should have exactly 2 villages' do
          Travian.villages_by_name("al").should have_exactly(2).villages
        end

        it 'should find "Almancil" and "São Brás de Alportel"' do
          Travian.villages_by_name("al").should == @villages
        end
      end
    end

    describe '.incoming_attacks?' do
      context 'given there are incoming attacks' do
        before :each do
          FakeWeb.register_uri(
            :get,
            "http://tx3.travian.com.br/dorf3.php",
            :body => "./spec/fakeweb_pages/brx_dorf3_under_attack.html",
            :content_type => "text/html"
          )
        end

        it 'returns true' do
          Travian.incoming_attacks?.should be true
        end
      end

      context 'given there are no incoming attacks' do
        before :each do
          FakeWeb.register_uri(
            :get,
            "http://tx3.travian.com.br/dorf3.php",
            :body => "./spec/fakeweb_pages/brx_dorf3.html",
            :content_type => "text/html"
          )
        end

        it 'returns false' do
          Travian.incoming_attacks?.should be false
        end
      end
    end
  end
end
