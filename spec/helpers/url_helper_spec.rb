require 'spec_helper.rb'

module Travian
  module Helpers
    describe UrlHelper do
      describe '.base_url' do
        it 'returns the server base url' do
          UrlHelper.base_url.should == Travian.config.server
        end
      end

      describe '.url_for' do
        before :each do
          @base_url = Travian.config.server
        end

        context 'when passed a village' do
          before :each do
            @village = Village.new('Almancil', 67924)
          end
          it 'it should return its link' do
            UrlHelper.url_for(@village).should == @base_url + "/dorf1.php?newdid=67924"
          end
        end

        context 'when passed the :villages symbol' do
          it 'returns the server base url + "/dorf3.php"' do
            UrlHelper.url_for(:villages).should == @base_url + "/dorf3.php"
          end
        end
      end
    end
  end
end
