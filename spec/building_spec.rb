require 'spec_helper.rb'
require 'travian/building'

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?aid=217",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_gids.html',
  :content_type => 'text/html'
)

module Travian
  describe Building do
    subject { @building = Building.new(17, 22, 5)}

    its(:id) { should == 22 }

  end
end
