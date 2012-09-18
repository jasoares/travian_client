require 'spec_helper.rb'

module Travian
  module Helpers
    describe UrlHelper do
      context 'when the Travian server is configured with "server.travian.com"' do
        describe '.base_url' do
          it 'should return "http://server.travian.com"' do
            UrlHelper.base_url.should == "http://tx3.travian.com.br"
          end
        end
      end
    end
  end
end
