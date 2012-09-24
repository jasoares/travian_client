require 'spec_helper.rb'

module Travian
  module Helpers
    describe UrlHelper do
      describe '.url_for' do
        it 'returns /dorf1.php?newdid=67924 when passed a village with that id' do
          village = double("village", :id => 67924)
          UrlHelper.url_for(:resources, village).should == "/dorf1.php?newdid=67924"
        end

        it 'returns "/dorf2.php?newdid=43968"' do
          v = double("village", :id => 43968)
          UrlHelper.url_for(:center, v).should == "/dorf2.php?newdid=43968"
        end

        it 'returns "/dorf3.php" when passed :villages' do
          UrlHelper.url_for(:villages).should == "/dorf3.php"
        end

        it 'returns "/dorf1.php" when passed :resources' do
          UrlHelper.url_for(:resources).should == "/dorf1.php"
        end

        it 'returns "/dorf2.php" when passed :center' do
          UrlHelper.url_for(:center).should == "/dorf2.php"
        end

        it 'returns "/karte.php" when passed :map' do
          UrlHelper.url_for(:map).should == "/karte.php"
        end

        it 'returns "/statistiken.php" when passed :statistics' do
          UrlHelper.url_for(:statistics).should == "/statistiken.php"
        end

        it 'returns "/nachrichten.php" when passed :messages' do
          UrlHelper.url_for(:messages).should == "/nachrichten.php"
        end

        it 'returns "/berichte.php" when passed :reports' do
          UrlHelper.url_for(:reports).should == "/berichte.php"
        end

        context 'when passed :building' do
          before(:all) { fake_building_gids_lookup_page }

          it 'returns "/build.php"' do
            UrlHelper.url_for(:building).should == "/build.php"
          end

          context 'when also passed a village of id=43968' do
            before(:each) { @v = double("village", :id => 43968) }

            it 'returns "/build.php?newdid=43968"' do
              UrlHelper.url_for(:building, @v).should == "/build.php?newdid=43968"
            end

            it 'returns "/build.php?newdid=43968&gid=16" when also passed :gid => :rally_point' do
              UrlHelper.url_for(:building, @v, :gid => :rally_point).
                should == "/build.php?newdid=43968&gid=16"
            end

            it 'returns "/build.php?newdid=43968&gid=16&tt=1 when also passed {:gid => :rally_point, :tt => 1} as params' do
              UrlHelper.url_for(:building, @v, :gid => :rally_point, :tt => 1).
                should == "/build.php?newdid=43968&gid=16&tt=1"
            end
          end
        end
      end
    end
  end
end
