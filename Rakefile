# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task 'db:init' do
  sh 'rails db:drop'
  sh 'rails db:migrate'
  sh 'rails db:seed'
end
