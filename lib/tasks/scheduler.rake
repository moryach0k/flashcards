namespace :users do
  desc "This task is sending email to user about his pending cards"
  task :notify_about_pending_cards => :environment do
    User.notify_about_pending_cards
  end
end