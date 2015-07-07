json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :category, :description, :circle_id
  json.url task_url(task, format: :json)
end
