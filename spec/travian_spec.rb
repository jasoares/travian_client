require 'spec_helper.rb'

module Travian
  describe Travian do
    describe '.configure' do
      it 'yields the configuration object to allow setting its attributes' do
        Travian.configure do |conf|
          conf.should be_a Configuration
        end
      end
    end
  end
end
