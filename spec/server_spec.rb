require 'spec_helper.rb'
require 'travian/server'

FakeWeb.register_uri(
  :get,
  "http://status.travian.com",
  :body => "./spec/fakeweb_pages/answers/status_travian_com.html",
  :content_type => 'text/html'
)

module Travian
  describe Server do
    describe '#to_s' do
      context 'given a server with status UP and host ts4.travian.pt' do
        before(:each) { @server = Server.new('ts4.travian.pt', 0) }

        it 'should return "#<Travian::Server:0x00000001cd4e88 @host="ts4.travian.pt", @status=0>"' do
          str = "#<Travian::Server:0x#{@server.__id__.to_s(16)} @host=\"ts4.travian.pt\", @status=\"UP\">"
          @server.to_s.should == str
        end
      end
    end

    describe '.keys' do
      it 'should return an array of ordered country codes' do
        codes = [:ae, :au, :ba, :bg, :br, :cl, :cn, :cz, :de, :dk, :ee, :eg, :com, :es, :fi, :fr, :gq, :gr, :hk, :hr, :hu, :id, :il, :ine, :ir, :it, :jp, :lt, :lv, :ma, :my, :nl, :no, :ph, :pk, :pl, :pt, :ro, :rs, :ru, :sa, :se, :si, :sk, :arabia, :th, :tr, :tw, :ua, :uk, :us, :vn, :za]
        Server.keys.should == codes
      end
    end

    describe '.servers' do
      it 'should return a hash of country codes as keys and an array of ordered servers as its values' do
        servers = {:ae=>["tc8.travian.ae", "ts1.travian.ae", "ts2.travian.ae", "ts4.travian.ae", "ts7.travian.ae", "ts9.travian.ae"], :au=>["tc4.travian.com.au", "ts3.travian.com.au", "ts5.travian.com.au", "tx3.travian.com.au"], :ba=>["ts1.travian.ba", "ts2.travian.ba", "ts4.travian.ba"], :bg=>["tc5.travian.bg", "ts1.travian.bg", "ts2.travian.bg", "ts4.travian.bg", "ts6.travian.bg", "tx3.travian.bg"], :br=>["tc1.travian.com.br", "ts2.travian.com.br", "ts3.travian.com.br", "ts4.travian.com.br", "ts5.travian.com.br", "ts6.travian.com.br", "ts7.travian.com.br", "ts8.travian.com.br", "tx3.travian.com.br"], :cl=>["tc2.travian.cl", "ts1.travian.cl", "ts3.travian.cl", "ts5.travian.cl", "ts6.travian.cl", "ts7.travian.cl", "ts8.travian.cl", "ts9.travian.cl", "tx3.travian.cl"], :cn=>["tc4.travian.cc", "ts1.travian.cc", "ts2.travian.cc", "ts5.travian.cc", "ts6.travian.cc", "ts7.travian.cc", "tx3.travian.cc"], :cz=>["tc6.travian.cz", "ts2.travian.cz", "ts3.travian.cz", "ts4.travian.cz", "ts7.travian.cz"], :de=>["tc11.travian.de", "ts1.travian.de", "ts3.travian.de", "ts4.travian.de", "ts5.travian.de", "ts6.travian.de", "ts7.travian.de", "ts8.travian.de", "www.travian.org"], :dk=>["tc5.travian.dk", "ts1.travian.dk", "ts2.travian.dk", "ts4.travian.dk", "tx3.travian.dk"], :ee=>["ts1.travian.co.ee", "ts2.travian.co.ee", "ts4.travian.co.ee"], :eg=>["tc7.travian.com.eg", "ts1.travian.com.eg", "ts2.travian.com.eg", "ts3.travian.com.eg", "ts4.travian.com.eg", "ts5.travian.com.eg", "ts6.travian.com.eg"], :com=>["finals.travian.com", "tc3.travian.com", "ts1.travian.com", "ts2.travian.com", "ts4.travian.com", "ts6.travian.com", "ts7.travian.com", "ts8.travian.com", "ts9.travian.com", "tx3.travian.com"], :es=>["tc5.travian.net", "ts2.travian.net", "ts3.travian.net", "ts4.travian.net", "ts6.travian.net", "ts8.travian.net", "ts9.travian.net", "tx3.travian.net"], :fi=>["tc3.travian.fi", "ts1.travian.fi", "ts2.travian.fi", "ts5.travian.fi", "ts6.travian.fi", "tx3.travian.fi"], :fr=>["tc6.travian.fr", "ts2.travian.fr", "ts3.travian.fr", "ts4.travian.fr", "ts5.travian.fr", "ts7.travian.fr", "ts8.travian.fr", "ts9.travian.fr", "tx3.travian.fr"], :gq=>[], :gr=>["tc6.travian.gr", "ts1.travian.gr", "ts4.travian.gr", "ts5.travian.gr"], :hk=>["ts1.travian.hk", "ts2.travian.hk", "ts3.travian.hk", "ts4.travian.hk", "ts5.travian.hk", "tx3.travian.hk"], :hr=>["ts2.travian.com.hr", "ts6.travian.com.hr", "tx3.travian.com.hr"], :hu=>["ts1.travian.hu", "ts2.travian.hu", "ts5.travian.hu", "ts7.travian.hu"], :id=>["tc6.travian.co.id", "ts4.travian.co.id", "ts5.travian.co.id", "ts7.travian.co.id", "tx3.travian.co.id"], :il=>["ts1.travian.co.il", "ts2.travian.co.il", "ts3.travian.co.il", "ts5.travian.co.il"], :ine=>["tc3.travian.in", "ts2.travian.in", "ts5.travian.in", "tx3.travian.in"], :ir=>["ts1.travian.ir", "ts10.travian.ir", "ts11.travian.ir", "ts12.travian.ir", "ts13.travian.ir", "ts2.travian.ir", "ts3.travian.ir", "ts4.travian.ir", "ts5.travian.ir", "ts6.travian.ir", "ts7.travian.ir", "ts8.travian.ir", "ts9.travian.ir", "tx3.travian.ir"], :it=>["tc8.travian.it", "ts2.travian.it", "ts3.travian.it", "ts4.travian.it", "ts5.travian.it", "ts6.travian.it", "tx3.travian.it"], :jp=>["tc7.travian.jp", "ts2.travian.jp", "ts3.travian.jp", "ts4.travian.jp", "tx3.travian.jp"], :lt=>["ts1.travian.lt", "ts2.travian.lt", "ts3.travian.lt", "ts4.travian.lt", "ts5.travian.lt", "ts6.travian.lt"], :lv=>["tc5.travian.lv", "ts2.travian.lv", "ts3.travian.lv", "tx3.travian.lv"], :ma=>["ts2.travian.ma", "ts3.travian.ma", "ts4.travian.ma", "ts5.travian.ma", "tx3.travian.ma"], :my=>["tc5.travian.com.my", "ts1.travian.com.my", "ts4.travian.com.my", "ts6.travian.com.my", "ts7.travian.com.my"], :nl=>["tc7.travian.nl", "ts2.travian.nl", "ts3.travian.nl", "ts4.travian.nl", "ts5.travian.nl", "ts8.travian.nl", "tx3.travian.nl"], :no=>["tc3.travian.no", "ts1.travian.no", "ts4.travian.no", "tx3.travian.no"], :ph=>["tc4.travian.ph", "ts3.travian.ph", "ts5.travian.ph", "tx3.travian.ph"], :pk=>["ts1.travian.pk", "ts2.travian.pk", "ts3.travian.pk", "tx3.travian.pk"], :pl=>["tc3.travian.pl", "ts1.travian.pl", "ts2.travian.pl", "ts4.travian.pl", "ts5.travian.pl", "ts6.travian.pl", "ts7.travian.pl", "ts8.travian.pl"], :pt=>["tc9.travian.pt", "ts1.travian.pt", "ts10.travian.pt", "ts2.travian.pt", "ts3.travian.pt", "ts4.travian.pt", "ts5.travian.pt", "ts6.travian.pt", "tx3.travian.pt"], :ro=>["tc5.travian.ro", "ts1.travian.ro", "ts4.travian.ro", "ts6.travian.ro", "ts7.travian.ro"], :rs=>["ts1.travian.rs", "ts2.travian.rs", "ts3.travian.rs", "ts4.travian.rs", "ts5.travian.rs", "tx3.travian.rs"], :ru=>["tc5.travian.ru", "test.travian.ru", "ts2.travian.ru", "ts3.travian.ru", "ts6.travian.ru", "ts7.travian.ru", "ts8.travian.ru", "ts9.travian.ru"], :sa=>["ts10.travian.com.sa", "ts11.travian.com.sa", "ts12.travian.com.sa", "ts13.travian.com.sa", "ts14.travian.com.sa", "ts3.travian.com.sa", "ts4.travian.com.sa", "ts6.travian.com.sa", "ts7.travian.com.sa", "ts8.travian.com.sa", "ts9.travian.com.sa", "tx3.travian.com.sa", "tx5.travian.com.sa"], :se=>["ts2.travian.se", "ts3.travian.se", "ts4.travian.se", "ts5.travian.se"], :si=>["ts6.travian.si"], :sk=>["tc3.travian.sk", "ts1.travian.sk", "ts4.travian.sk", "ts5.travian.sk", "ts6.travian.sk", "tx3.travian.sk"], :arabia=>["arabiatc4.travian.com", "arabiats2.travian.com", "arabiats5.travian.com", "arabiats6.travian.com", "arabiats7.travian.com"], :th=>["tc4.travian.asia", "ts1.travian.asia", "ts2.travian.asia", "ts3.travian.asia", "ts5.travian.asia", "ts8.travian.asia", "tx3.travian.asia"], :tr=>["tc5.travian.com.tr", "ts1.travian.com.tr", "ts12.travian.com.tr", "ts2.travian.com.tr", "ts3.travian.com.tr", "ts4.travian.com.tr", "ts6.travian.com.tr", "ts7.travian.com.tr", "ts8.travian.com.tr", "ts9.travian.com.tr", "tx3.travian.com.tr"], :tw=>["ts1.travian.tw", "ts5.travian.tw", "ts6.travian.tw", "tx3.travian.tw"], :ua=>["tc4.travian.com.ua", "ts2.travian.com.ua", "ts5.travian.com.ua", "ts6.travian.com.ua", "tx3.travian.com.ua"], :uk=>["ts1.travian.co.uk", "ts3.travian.co.uk", "ts4.travian.co.uk", "ts5.travian.co.uk", "ts6.travian.co.uk"], :us=>["tc3.travian.us", "ts4.travian.us", "ts5.travian.us", "ts7.travian.us", "ts8.travian.us", "tx3.travian.us"], :vn=>["tc5.travian.com.vn", "ts1.travian.com.vn", "ts2.travian.com.vn", "ts4.travian.com.vn", "tx3.travian.com.vn"], :za=>["ts1.travian.co.za", "ts2.travian.co.za", "ts5.travian.co.za", "ts6.travian.co.za"]}
        Server.servers.should == servers
      end
    end

    describe '.list' do
      it 'should return a hash of country codes as keys and an array of ordered servers as its values' do
        servers = {}
        Server.list.should == servers
      end
    end

    describe '.servers_from' do
      it 'should return the portuguese list of servers when passed :pt' do
        pt_servers = ["ts2.travian.pt", "tx3.travian.pt", "ts6.travian.pt", "ts5.travian.pt", "ts10.travian.pt", "ts3.travian.pt", "tc9.travian.pt", "ts1.travian.pt", "ts4.travian.pt"].sort
        Server.servers_from(:pt).should == pt_servers
      end
    end

    class Server
      describe '.[]' do
        it 'returns UP when passed 0' do
          Status[0].should == Status::UP
        end

        it 'returns DOWN when passed 1' do
          Status[1].should == Status::DOWN
        end
      end
    end
  end
end
