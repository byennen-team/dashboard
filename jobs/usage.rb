require 'httparty'

SCHEDULER.every '2s' do
  data = HTTParty.get("http://ec2-54-200-175-37.us-west-2.compute.amazonaws.com:4444/grid/api/status")
  available_browsers = data["slots"]["available"]
  puts "OWIFEJOEWIFJOI"
  send_event('current_usage', {available: available_browsers})
end
