set :output, 'log/crontab.log'
set :environment, :production

every 1.hours do
  rake 'feeds:update'
end
