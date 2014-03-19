json.array!(@pages) do |page|
  json.extract! page, :id, :name, :site_id, :content
  json.url page_url(page, format: :json)
end
