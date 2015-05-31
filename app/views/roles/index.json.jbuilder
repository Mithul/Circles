json.array!(@roles) do |role|
  json.extract! role, :id, :circle_id, :member_id, :name, :description
  json.url role_url(role, format: :json)
end
