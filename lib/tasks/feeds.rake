namespace :feeds do
  desc 'Update feeds'
  task update: :environment do
    Feed.all.each do |feed|
      begin
        feed.refresh
        feed.users.each do |user|
          feed.initialize_reading_statuses(user)
        end
      rescue => e
        puts e
      end
    end
  end
end
