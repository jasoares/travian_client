require 'spec_helper.rb'
require 'travian/agent'

FakeWeb.register_uri(
  :get,
  "http://www.google.com",
  :body => '<html><head><title>Google</title></head><body><h2>google.com</h2></html>',
  :content_type => 'text/html'
)

module Travian
  describe Agent do
    describe '.get' do
      it 'delegates its behaviour to Mechanize::Agent when passed a string' do
        Agent.agent.should_receive(:get).with("http://www.google.com")
        Agent.get("http://www.google.com")
      end

      context 'when passed a hash' do
        before :each do
          Agent.stub(:answers) { "http://t4.answers.travian.org/?view=toolkit&action=buildingconstructiontimes&gid=17&speed=1&unwrapped" }
          Agent.agent.stub(:get) { nil }
        end

        it 'delegates the hash argument to answers' do
          Agent.should_receive(:answers).with(:building => :marketplace, :const_times => true, :speed => 1)
          Agent.get(:building => :marketplace, :const_times => true, :speed => 1)
        end

        it 'channels the return value of Agent.answers to Mechanize::Agent' do
          Agent.agent.should_receive(:get).with("http://t4.answers.travian.org/?view=toolkit&action=buildingconstructiontimes&gid=17&speed=1&unwrapped")
          Agent.get(:building => :marketplace, :const_times => true, :speed => 1)
        end
      end
    end
  end
end
