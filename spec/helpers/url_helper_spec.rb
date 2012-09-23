require 'spec_helper.rb'

module Travian
  module Helpers
    describe UrlHelper do
      before :all do
        Travian.configure do |brx|
          brx.server = 'tx3.travian.com.br'
        end
      end

      describe '.url_for' do
        context 'when passed a village' do
          before :each do
            @village = Village.new('Almancil', 67924)
          end
          it 'it should return its link' do
            UrlHelper.url_for(@village).should == "/dorf1.php?newdid=67924"
          end
        end

        context 'when passed the :villages symbol' do
          it 'returns the server base url + "/dorf3.php"' do
            UrlHelper.url_for(:villages).should == "/dorf3.php"
          end
        end
      end
    end
  end
end
