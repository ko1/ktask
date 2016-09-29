json.extract! result, :id, :task_id, :status, :short_result, :result, :created_at, :updated_at
json.url result_url(result, format: :json)