class CompanyStockReport

  include Datagrid

  scope { CompanyStock.order(:id) }
  
  filter(:stock_country_id, :enum, header: "Country", select: ->{ StockCountry.pluck(:name, :id) })
  filter(:category_id, :enum, header: "Category", select: ->{ Category.pluck(:name, :id) })
  filter(:sensex, :string, header: "Sensex") {|value| where("sensex ilike ?", "%#{value}%")}
  filter(:currency, :string, header: "Currency") {|value| where("currency ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "company_stocks.id")
  column(:stock_country_id, header: "Category") do |model|
    model.stock_country_id ? model.stock_country.name : ""
  end
  column(:category_id, header: "Category") do |model|
    model.category_id ? model.category.name : ""
  end
  column(:sensex, header: "Sensex", :order => "company_stocks.sensex")
  column(:currency, header: "Currency", :order => "company_stocks.currency")
  column(:date_format, header: "Date Format", :order => "company_stocks.date_format")
  column(:updated_at, html: true, header: "Updated At") { |company_stock| content_tag :span, time_ago_in_words(company_stock.updated_at), title: company_stock.updated_at.to_formatted_s(:long) if company_stock.updated_at }
  
  column(:actions, header: "Action", html: true  ) do |company_stock|
    html = link_to "", admin_company_stock_path(company_stock), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View company stock"
    html += link_to "", edit_admin_company_stock_path(company_stock), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit company stock"
    html
  end

end