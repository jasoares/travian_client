require 'spec_helper.rb'

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
              conf.server = 'usx.travian.com'
              conf.user = 'nick'
              conf.password = 'secret_word'
            end
          }.to_not raise_error
        end

        it 'allows to configure Travian using a block and configuration as a hash' do
          expect {
            Travian.configure do |conf|
              conf[:server] = 'tx3.travian.com.br'
              conf[:user] = 'name'
              conf[:password] = 'pass'
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
  end
end
