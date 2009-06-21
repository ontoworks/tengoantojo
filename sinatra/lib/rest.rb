def get(uri)
  url = URI.parse(uri)
#  req = Net::HTTP::Get.new(url.path)
  res = Net::HTTP.start(url.host, url.port) {|http|
#    http.request(req)
  }
#  puts res.body
end
