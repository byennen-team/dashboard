require 'httparty'
require 'pry'

SCHEDULER.every '3s' do
  data = HTTParty.get("http://ec2-54-200-175-37.us-west-2.compute.amazonaws.com:4444/grid/api/status")
  available_browsers = { linux: {firefox: 0, chrome: 0},
                         mac: {firefox: 0, chrome: 0},
                         vista: {chrome:0, firefox:0, ie9: 0}}

  data["slots"]["available"].each do |slot|
    next if slot["platform"] == "WINDOWS"
    available_browsers[slot["platform"].downcase.to_sym][slot["browserName"].to_sym]+= 1
  end

  send_event('current_slots', available_browsers)
end
