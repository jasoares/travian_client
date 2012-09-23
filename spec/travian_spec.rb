require 'spec_helper.rb'

FakeWeb.register_uri(
  :get,
  "http://tx3.travian.com.br",
  :body => "./spec/fakeweb_pages/brx_login.html",
  :content_type => "text/html"
)

module Travian
  describe Travian do
    describe '.configure' do
      context 'when passed a block' do
        it 'yields a configuration object to the block' do
          Travian.configure do |conf|
            conf.should be_a Configurable
          end
        end

        it 'allows to configure Travian using a block and configuration methods' do
          expect {
            Travian.configure do |conf|
              conf.server = 'tx3.travian.com.br'
              conf.user = 'username'
              conf.password = 'password'
            end
          }.to_not raise_error
        end

        it 'allows to configure Travian using a block and configuration as a hash' do
          expect {
            Travian.configure do |conf|
              conf[:server] = 'tx3.travian.com.br'
              conf[:user] = 'username'
              conf[:password] = 'password'
            end
          }.to_not raise_error
        end
      end
    end
  end
end
