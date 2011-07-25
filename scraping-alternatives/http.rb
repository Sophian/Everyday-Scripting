
def test_echoing
  HTTP.start('www.testing.com') do |server|
    name = CGI.escape("Brian Marick")
    count = CGI.escape("3")
    params = "name=#{name}&count=#{count}"
    response = server.post('/cgi-bin/post-example', params)
    assert_match(/Brian Marick/, response.body)
    assert_match(/count is 3/, response.body)
  end
end
