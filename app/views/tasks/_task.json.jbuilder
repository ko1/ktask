json.extract! task, :id, :name, :script, :priority, :repeat, :memo, :invoked, :created_at, :updated_at
json.url task_url(task, format: :json)