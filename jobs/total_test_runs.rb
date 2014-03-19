require 'httparty'

SCHEDULER.every '20s' do
  auth = {username: 'autotest', password: 'dashboard'}
  test_runs_count = HTTParty.get("http://staging.autotest.io/api/dashing/total_tests_run", basic_auth: auth)
  test_runs_count[:total] = test_runs_count.values.sum
  puts "****************************************"
  send_event('total_test_runs', test_runs_count)
end
