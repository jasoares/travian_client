require 'spec_helper.rb'
require 'travian/user'
require 'travian/alliance'
require 'travian/tribe'

fake_user_profile
fake_invalid_user_profile
fake_user_profile_without_alliance
fake_alliance_profile

module Travian
	describe User do
    subject { @user = User.new(8964, 'jasoares', 127, 2, Alliance.parse(33)) }

    its(:uid) { should be 8964 }
    its(:name) { should == 'jasoares' }
    its(:rank) { should == 127 }
    its(:tribe) { should == Tribe::TEUTONS }
    its(:alliance) { should == Alliance.parse(33) }
    its(:has_alliance?) { should == true }

    describe '.parse' do
      it 'should return nil when passed an invalid uid' do
        User.parse(893).should be nil
      end

      it 'should return a User when passed a valid uid' do
        User.parse(8964).should be_a User
      end

      context 'given the uid passed matches a user with alliance' do
        it 'should create a user with alliance' do
          User.parse(8964).should have_alliance
        end
      end

      context 'given the uid passed matches a user without alliance' do
        it 'should create a user without alliance' do
          User.parse(14142).should_not have_alliance
        end
      end

      context 'given the uid passed matches the current user' do
        it 'should create a user with a tribe' do
          User.parse(8964).tribe.should == Tribe::TEUTONS
        end
      end

      context 'given the uid passed is a user other than the current user' do
        it 'should create a user with an unknown tribe' do
          User.parse(14142).tribe.should == Tribe::UNKNOWN
        end
      end
    end
  end
end
