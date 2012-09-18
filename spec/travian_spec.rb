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
            conf.should be_a Configuration
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

    describe '.config' do
      it 'returns the configuration object' do
        Travian.config.should be_a Configuration
      end
    end

    describe '.login' do
      context 'when it logs in successfully' do
        before :each do
          FakeWeb.register_uri(
            :post,
            "http://tx3.travian.com.br/dorf1.php",
            :body => "./spec/fakeweb_pages/brx_dorf1_success_login.html",
            :content_type => "text/html"
          )
        end

        it 'logs in to the account' do
          Travian.login.should be_a Mechanize
        end
      end

      context 'when it fails to login' do
        before :each do
          FakeWeb.register_uri(
            :post,
            "http://tx3.travian.com.br/dorf1.php",
            :body => "./spec/fakeweb_pages/brx_dorf1_failed_login.html",
            :content_type => "text/html"
          )
        end

        it 'should raise an InvalidConfigurationError' do
          expect { Travian.login }.to raise_error InvalidConfigurationError
        end
      end
    end

    describe '.bot' do
      it 'returns the Mechanize agent' do
        Travian.bot.should be_a Mechanize
      end
    end
  end
end
