# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :inits do
  sh 'rails db:drop'
  sh 'rails destroy model Tasks'
  sh 'rails destroy controller Tasks'
  sh 'rails destroy model Results'
  sh 'rails destroy controller Results'
  sh 'rails generate scaffold Task name:string script:text priority:integer repeat:boolean memo:string invoked:boolean'
  sh 'rails generate scaffold Result task:belongs_to status:string short_result:string result:text'
  sh 'rails db:migrate'
end
