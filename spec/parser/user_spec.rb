#encoding: utf-8
require 'spec_helper.rb'

module Travian::Parser
  describe User do
    let(:no_user) { User.new(load_page('brx_spieler_uid_893_no_user')) }
    let(:other_user) { User.new(load_page('brx_spieler_uid_14142_no_alliance')) }
    let(:no_alliance) { other_user }
    let(:logged_user) { User.new(load_page('brx_spieler_uid_8964')) }

    describe '#attrs' do
      context 'given a valid user profile' do
        subject { logged_user.attrs }

        it { should be_a Hash }
        it { should have_key :id }
        it { should have_key :name }
        it { should have_key :rank }
        it { should have_key :tribe }
        it { should have_key :alliance_id }
        it { should have_key :population }
        it { should have_key :logged_user? }
        it { should have_key :villages }

      end

      context 'given an invalid user profile' do
        it 'returns nil' do
          no_user.attrs.should be_nil
        end
      end

    end

    describe '#exists?' do
      context 'given an invalid user profile' do
        it 'returns false' do
          no_user.send(:exists?).should be_false
        end
      end

      context 'given a valid user profile' do
        it 'returns true' do
          logged_user.send(:exists?).should be_true
        end
      end
    end

    describe '#logged_user?' do
      context 'given another user\'s profile' do
        it 'returns false' do
          other_user.send(:logged_user?).should be_false
        end
      end

      context 'given the logged user\'s profile' do
        it 'returns true' do
          logged_user.send(:logged_user?).should be_true
        end
      end
    end

    describe '#profile_id' do
      it 'calls #user_id if it is the logged user' do
        logged_user.should_receive(:user_id).and_return(8964)
        logged_user.send(:profile_id).should == 8964
      end

      it 'returns the profile users id otherwise' do
        other_user.send(:profile_id).should == 14142
      end
    end

    describe '#profile_name' do
      it 'calls #user_name if it is the logged user' do
        logged_user.should_receive(:user_name).and_return('jasoares')
        logged_user.send(:profile_name).should == 'jasoares'
      end

      it 'returns the profile user name if it is another user' do
        other_user.send(:profile_name).should == 'Celsius'
      end
    end

    describe '#rank' do
      it 'should return the profile rank attribute' do
        logged_user.send(:rank).should == 127
      end

      it 'should return the profile rank attribute' do
        other_user.send(:rank).should == 3805
      end
    end

    describe '#tribe' do
      it 'should return the profile tribe attribute' do
        logged_user.send(:tribe).should == 'Teutões'
      end

      it 'should return the profile tribe attribute' do
        other_user.send(:tribe).should == 'Romanos'
      end
    end

    describe '#alliance_id' do
      it 'should return the profile alliance_id attribute' do
        logged_user.send(:alliance_id).should == 33
      end

      it 'should return the profile alliance_id attribute' do
        no_alliance.send(:alliance_id).should == nil
      end
    end

    describe '#population' do
      it 'should return the profile population attribute' do
        logged_user.send(:population).should == 8559
      end

      it 'should return the profile population attribute' do
        other_user.send(:population).should == 0
      end
    end

    describe '#villages' do
      it 'should delegate parsing to VillageRow and pass it each village row' do
        other_user.send(:villages).should == [
          {
            d: 252778,
            name: "Macedônia",
            capital?: true,
            population: 0,
            coordinates: { x: 62, y: 85 }
          }
        ]
      end
    end
  end
end
