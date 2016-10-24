class GraphReport

  include Datagrid

  scope { Graph.order(:id) }

  filter(:company_stock_id, :enum, header: "Country", select: ->{ CompanyStock.pluck(:sensex_co, :id) })
  filter(:industry_id, :enum, header: "Industry", select: ->{ Industry.pluck(:name, :id) })
  filter(:company_code, :string, header: "Company Code") {|value| where("company_code ilike ?", "%#{value}%")}
  
  
  column(:id, header: "id", :order => "graphs.id")
  column(:company_stock_id, header: "Country") do |model|
    model.company_stock_id ? model.company_stock.sensex_co : "Not Available"
  end
  column(:industry_id, header: "Industry") do |model|
    model.industry_id ? model.industry.name : "Not Available"
  end
  column(:company_code, header: "Company Code", :order => "graphs.company_code")
  column(:updated_at, html: true, header: "Updated At") { |graph| content_tag :span, time_ago_in_words(graph.updated_at), title: graph.updated_at.to_formatted_s(:long) if graph.updated_at }
  column(:actions, header: "Action", html: true  ) do |graph|
    html = link_to "", admin_graph_path(graph), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View graph"
    html += link_to "", edit_admin_graph_path(graph), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit graph"
    html += link_to "", admin_graph_path(graph), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove graph", 'data-confirm' => 'Are you sure?'
    html
  end

end