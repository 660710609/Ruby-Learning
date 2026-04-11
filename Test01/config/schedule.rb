# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:

set :path, "/Users/patchara/Desktop/Ruby/Ruby-Learning/Test01"


set :bundle_command, "/Users/patchara/.rbenv/shims/bundle"

env :PATH, "/Users/patchara/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
env :RBENV_VERSION, "3.3.0"

job_type :runner, "cd :path && :bundle_command exec rails runner ':task' :output 2>&1"

set :output, "log/cron_`date + \\%Y-\\%m-\\%d`.log"

every 1.day, at: "8:00 am" do
  runner "OilPriceScraper.call"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
