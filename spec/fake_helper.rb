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

def fake_user_profile
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/spieler.php?uid=8964",
    :body => "./spec/fakeweb_pages/brx_spieler_uid_8964.html",
    :content_type => "text/html"
  )
end

def fake_alliance_profile
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/allianz.php?aid=33",
    :body => "./spec/fakeweb_pages/brx_allianz_aid_33.html",
    :content_type => "text/html"
  )
end

def fake_invalid_user_profile
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/spieler.php?uid=893",
    :body => "./spec/fakeweb_pages/brx_spieler_uid_893_no_user.html",
    :content_type => "text/html"
  )
end

def fake_user_profile_without_alliance
  FakeWeb.register_uri(
    :get,
    "http://tx3.travian.com.br/spieler.php?uid=14142",
    :body => "./spec/fakeweb_pages/brx_spieler_uid_14142_no_alliance.html",
    :content_type => "text/html"
  )
end

def fake_status_page
  FakeWeb.register_uri(
    :get,
    "http://status.travian.com",
    :body => "./spec/fakeweb_pages/status_travian_com.html",
    :content_type => "text/html"
  )
end
