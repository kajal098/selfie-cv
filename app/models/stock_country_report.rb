class StockCountryReport

  include Datagrid

  scope { StockCountry.order(:id) }
  
  # filter(:id, header: "Id") {|value| where("id ilike ?", "%#{value}%")}
  #filter(:id, header: "Personeelsnummer")
  filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "stock_countries.id")
  column(:name, header: "Name") do |model|
    model.name.capitalize
  end
  column(:created_at, html: true, header: "Created At") { |stock_country| content_tag :span, time_ago_in_words(stock_country.created_at), title: stock_country.created_at.to_formatted_s(:long) if stock_country.created_at }
  column(:updated_at, html: true, header: "Updated At") { |stock_country| content_tag :span, time_ago_in_words(stock_country.updated_at), title: stock_country.updated_at.to_formatted_s(:long) if stock_country.updated_at }
  
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |stock_country| content_tag :span, time_ago_in_words(stock_country.last_sign_in_at), title: stock_country.last_sign_in_at.to_formatted_s(:long) if stock_country.last_sign_in_at }
  column(:actions, header: "Action", html: true  ) do |stock_country|
    html = link_to "", admin_stock_country_path(stock_country), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View stock_country"
    html += link_to "", edit_admin_stock_country_path(stock_country), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit stock_country"
    html += link_to "", admin_stock_country_path(stock_country), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove stock_country", 'data-confirm' => 'Are you sure?'
    html
  end

end