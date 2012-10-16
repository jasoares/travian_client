require 'spec_helper.rb'
require 'travian/user'

module Travian
	describe User do
    subject { @user = User.new(8964, 'jasoares', 33) }

    its(:uid) { should be 8964 }
    its(:name) { should == 'jasoares' }
    its(:aid) { should be 33}

  end
end
