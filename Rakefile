# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require 'FileUtils'
Rake::Task["assets:clean"].enhance do
  puts 'my assets:precompile hook has started'
  FileUtils.remove_dir "#{Rails.root}/public/assets", true
  puts 'my assets:precompile hook is finished'
end

Americo::Application.load_tasks
