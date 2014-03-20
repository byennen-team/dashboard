require 'httparty'

SCHEDULER.in '2s' do
  auth = {username: 'autotest', password: 'dashboard'}
  data = HTTParty.get("http://staging.autotest.io/api/dashing/total_minutes", basic_auth: auth)
  data.each do |k, v|
    data[k] = Time.at(v.to_i).utc.strftime("%H:%M:%S")
  end
  send_event('total_minutes', data)
end
