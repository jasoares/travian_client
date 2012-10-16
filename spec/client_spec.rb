require 'spec_helper.rb'

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?aid=217",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_gids.html',
  :content_type => 'text/html'
)

module Travian
  describe Client do
    describe '#url_for' do
      before(:each) do
        @client = Travian.send(:client)
      end

      it 'returns /dorf1.php?newdid=67924 when passed a village with that id' do
        village = double("village", :id => 67924)
        @client.url_for(:resources, village).should == "/dorf1.php?newdid=67924"
      end

      it 'returns "/dorf2.php?newdid=43968"' do
        v = double("village", :id => 43968)
        @client.url_for(:center, v).should == "/dorf2.php?newdid=43968"
      end

      it 'returns "/dorf3.php" when passed :villages' do
        @client.url_for(:villages).should == "/dorf3.php"
      end

      it 'returns "/dorf1.php" when passed :resources' do
        @client.url_for(:resources).should == "/dorf1.php"
      end

      it 'returns "/dorf2.php" when passed :center' do
        @client.url_for(:center).should == "/dorf2.php"
      end

      it 'returns "/karte.php" when passed :map' do
        @client.url_for(:map).should == "/karte.php"
      end

      it 'returns "/statistiken.php" when passed :statistics' do
        @client.url_for(:statistics).should == "/statistiken.php"
      end

      it 'returns "/nachrichten.php" when passed :messages' do
        @client.url_for(:messages).should == "/nachrichten.php"
      end

      it 'returns "/berichte.php" when passed :reports' do
        @client.url_for(:reports).should == "/berichte.php"
      end

      context 'when passed :building' do
        before(:all) { fake_building_gids_lookup_page }

        it 'returns "/build.php"' do
          @client.url_for(:building).should == "/build.php"
        end

        context 'when also passed a village of id=43968' do
          before(:each) { @v = double("village", :id => 43968) }

          it 'returns "/build.php?newdid=43968"' do
            @client.url_for(:building, @v).should == "/build.php?newdid=43968"
          end

          it 'returns "/build.php?newdid=43968&gid=16" when also passed :gid => :rally_point' do
            @client.url_for(:building, @v, :gid => :rally_point).
              should == "/build.php?newdid=43968&gid=16"
          end

          it 'returns "/build.php?newdid=43968&gid=16&tt=1 when also passed {:gid => :rally_point, :tt => 1} as params' do
            @client.url_for(:building, @v, :gid => :rally_point, :tt => 1).
              should == "/build.php?newdid=43968&gid=16&tt=1"
          end
        end
      end
    end
  end
end
