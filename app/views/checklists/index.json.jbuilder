json.array!(@checklists) do |checklist|
  json.extract! checklist, :id, :title, :circle_id, :user_id
  json.url checklist_url(checklist, format: :json)
end
