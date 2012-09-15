require 'spec_helper.rb'

module Travian
  module Helpers
    describe UrlHelper do
      context 'when the Travian server is configured with "ts4.travian.com"' do
        before :each do
          Travian.configure {|config| config.server = 'ts4.travian.com' }
        end
        describe '.base_url' do
          it 'should return the server root url' do
            UrlHelper.base_url.should == "http://ts4.travian.com"
          end
        end
      end
    end
  end
end
