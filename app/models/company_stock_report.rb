class CompanyStockReport

  include Datagrid

  scope { CompanyStock.order(:id) }
  scope { CompanyStock.all }

  filter(:sensex_co, :string, header: "Country") {|value| where("sensex_co ilike ?", "%#{value}%")}
  filter(:sensex, :string, header: "Sensex") {|value| where("sensex ilike ?", "%#{value}%")}
  filter(:currency, :string, header: "Currency") {|value| where("currency ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "company_stocks.id")
  column(:sensex_co, header: "Country", :order => "company_stocks.sensex_co")
  column(:sensex, header: "Sensex", :order => "company_stocks.sensex")
  column(:currency, header: "Currency", :order => "company_stocks.currency")
  column(:created_at, html: true, header: "Created At") { |company_stock| content_tag :span, time_ago_in_words(company_stock.created_at), title: company_stock.created_at.to_formatted_s(:long) if company_stock.created_at }
  column(:updated_at, html: true, header: "Updated At") { |company_stock| content_tag :span, time_ago_in_words(company_stock.updated_at), title: company_stock.updated_at.to_formatted_s(:long) if company_stock.updated_at }
  
  column(:actions, header: "Action", html: true  ) do |company_stock|
    html = link_to "", admin_company_stock_path(company_stock), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View company stock"
    html += link_to "", edit_admin_company_stock_path(company_stock), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit company stock"
    html
  end

end