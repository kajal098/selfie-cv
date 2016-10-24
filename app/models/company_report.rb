class CompanyReport

  include Datagrid

  scope { Company.order(:id) }
  scope { Company.all }

  filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "companies.id")
  column(:name, header: "Name", :order => "companies.name")
  column(:created_at, html: true, header: "Created At") { |company| content_tag :span, time_ago_in_words(company.created_at), title: company.created_at.to_formatted_s(:long) if company.created_at }
  column(:updated_at, html: true, header: "Updated At") { |company| content_tag :span, time_ago_in_words(company.updated_at), title: company.updated_at.to_formatted_s(:long) if company.updated_at }
  
  column(:actions, header: "Action", html: true  ) do |company|
    html = link_to "", admin_company_path(company), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View company"
    html += link_to "", edit_admin_company_path(company), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit company"
    html += link_to "", admin_company_path(company), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove company", 'data-confirm' => 'Are you sure?'
    html
  end

end