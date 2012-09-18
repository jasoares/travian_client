require 'spec_helper.rb'

FakeWeb.register_uri(
  :get,
  "http://tx3.travian.com.br/dorf3.php",
  :body => "./spec/fakeweb_pages/brx_dorf3.html",
  :content_type => "text/html"
)

module Travian
  describe Village do
    subject { Village }

    describe '.list' do
      it 'returns an array' do
        Village.list.should be_an Array
      end

      it 'should be an array with village objects' do
        Village.list.all? {|v| v.is_a? Village }.should be true
      end
    end

    context 'given the village almancil with id 67924' do
      before :each do
        @village = Village.list.first
      end

      describe '#name' do
        it 'should return "almancil"' do
          @village.name.should == "Almancil"
        end
      end

      describe '#id' do
        it 'should return 67924' do
          @village.id.should == 67924
        end
      end
    end
  end
end
