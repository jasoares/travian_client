def fake_login
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br",
    :body => "./spec/fakeweb_pages/brx_login.html",
    :content_type => "text/html"
  )
  FakeWeb.register_uri(
    :post,
    "http://tx3.travian.com.br/dorf1.php",
    :body => "./spec/fakeweb_pages/brx_dorf1.html",
    :content_type => "text/html"
  )
end

def fake_incoming_attacks
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/dorf3.php",
    :body => "./spec/fakeweb_pages/brx_dorf3_under_attack.html",
    :content_type => "text/html"
  )
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/dorf1.php?newdid=43968",
    :body => "./spec/fakeweb_pages/brx_dorf1_under_attack.html",
    :content_type => "text/html"
  )
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/build.php?newdid=43968&id=39&tt=1&gid=16",
    :body => "./spec/fakeweb_pages/brx_prm_under_attack.html",
    :content_type => "text/html"
  )
end

def fake_no_incoming_attacks
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/dorf3.php",
    :body => "./spec/fakeweb_pages/brx_dorf3.html",
    :content_type => "text/html"
  )
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/dorf1.php?newdid=43968",
    :body => "./spec/fakeweb_pages/brx_dorf1.html",
    :content_type => "text/html"
  )
end

def fake_basic_travian
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/dorf1.php",
    :body => "./spec/fakeweb_pages/brx_dorf1.html",
    :content_type => "text/html"
  )
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/dorf3.php",
    :body => "./spec/fakeweb_pages/brx_dorf3.html",
    :content_type => "text/html"
  )
end

def fake_building_gids_lookup_page
  FakeWeb.register_uri(
    :get,
    "http://answers.travian.com/index.php?aid=217",
    :body => "./spec/fakeweb_pages/answers_com_building_gids.html",
    :content_type => "text/html"
  )
end

def fake_rally_point_under_attack
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/build.php?newdid=43968&gid=16&tt=1",
    :body => "./spec/fakeweb_pages/brx_rally_point_under_attack.html",
    :content_type => "text/html"
  )
end

def fake_rally_point_under_raid_and_attack
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/build.php?newdid=43968&gid=16&tt=1",
    :body => "./spec/fakeweb_pages/brx_rally_point_under_raid_and_attack.html",
    :content_type => "text/html"
  )
end

def fake_rally_point_no_attacks
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/build.php?newdid=43968&gid=16&tt=1",
    :body => "./spec/fakeweb_pages/brx_rally_point_no_attacks.html",
    :content_type => "text/html"
  )
end
