json.array!(@reports) do |report|
  json.extract! report, :id, :title, :date, :duration, :venue, :initiator, :bucket, :participants, :description, :conclusion, :author, :inter, :othbucket
  json.url report_url(report, format: :json)
end
