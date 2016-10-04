json.extract! task, :id, :name, :description, :script, :priority, :repeat, :created_at, :updated_at
json.url task_url(task, format: :json)