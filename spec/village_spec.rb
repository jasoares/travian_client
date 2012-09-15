require 'spec_helper.rb'

module Travian
  describe Village do
    subject { Village }

    before :all do
      Travian.configure do |cfg|
        cfg.server = 'tx3.travian.com.br'
        cfg.user = 'jasoares'
        cfg.password = 'frohike'
      end
      Travian.login
    end

    describe '.list' do
      it 'returns an array' do
        Village.list.should be_an Array
      end

      it 'should be an array with village objects' do
        Village.list.all? {|v| v.is_a? Village }.should be true
      end
    end
  end
end
