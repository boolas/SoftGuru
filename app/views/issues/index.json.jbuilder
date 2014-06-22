json.array!(@issues) do |issue|
  json.extract! issue, :id, :name, :description, :type, :status, :project_id, :user_id, :owner_id
  json.url issue_url(issue, format: :json)
end
