module Security
  require 'digest/sha1'
  require 'base64'
  include CouchDBHelpers

  def login(username,password)
    login_couchdb(username,password)
  end

  def login_couchdb(username,password)
    r= query_view(:users,:security,:password_by_email,{:key=>user})
    user= r["rows"][0]
    if user["key"]==username && user["value"]==password
      true
    end
  end

  def signup(username,password,captcha)
    r= query_view(:users,:security,:password_by_email,{:key=>username})
    if r["rows"][0].empty?
      {"error"=>"User already exists with the given email"}
    else
      user={
        "email"=> username,
        "password"=> password
      }
      post_db(:users, user.to_json)
      # trigger side-events for signup
    end
  end
end
