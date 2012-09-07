require 'spec_helper.rb'

module Travian
  describe Configuration do
    before :each do
      @cfg = Configuration.new
    end

    subject { @cfg }

    it { should respond_to :attributes }

    it { should respond_to :keys }

    it { should respond_to :server }

    it { should respond_to :user }

    it { should respond_to :password }

    describe '.attributes' do
      it 'should return a list of setable attributes' do
        @cfg.attributes.should =~ [:server, :user, :password]
      end
    end

    describe '.[]=' do
      it 'should assign \'nickname\' to user when passed [:user] = \'nickname\'' do
        @cfg[:user] = 'nickname'
        @cfg.user.should == 'nickname'
      end

      it 'should assign \'secret\' to password when passed [:password] = \'secret\'' do
        @cfg[:password] = 'secret'
        @cfg.password.should == 'secret'
      end
    end

    describe '.[]' do
      it 'should show the current value of server when passed :server' do
        @cfg[:server].should == 'server.travian.com'
      end

      it 'should access the value stored in user attribute when passed :user' do
        @cfg.user = 'johndoe'
        @cfg[:user].should == 'johndoe'
      end
    end
  end
end
