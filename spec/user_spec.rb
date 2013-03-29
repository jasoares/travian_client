require 'spec_helper.rb'

module Travian
	describe User do
    let(:attrs) { { id: 8964, name: 'jasoares', rank: 127, tribe: 2, alliance_id: 33 } }
    subject { @user = User.new(attrs) }

    its(:id) { should be 8964 }
    its(:uid) { should be 8964 }
    its(:name) { should == 'jasoares' }
    its(:rank) { should == 127 }
    its(:tribe) { should == 2 }
    its(:alliance) { should == Alliance.new(id: 33 ) }
    its(:has_alliance?) { should == true }

  end
end
