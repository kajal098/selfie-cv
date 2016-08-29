class IndustryReport

  include Datagrid

  scope { Industry.order(:id) }
  scope { Industry.all }

  filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:name, header: "Name", :order => "industries.name")
  column(:created_at, html: true, header: "Created At") { |industry| content_tag :span, time_ago_in_words(industry.created_at), title: industry.created_at.to_formatted_s(:long) if industry.created_at }
  column(:updated_at, html: true, header: "Updated At") { |industry| content_tag :span, time_ago_in_words(industry.updated_at), title: industry.updated_at.to_formatted_s(:long) if industry.updated_at }
  
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |industry| content_tag :span, time_ago_in_words(industry.last_sign_in_at), title: industry.last_sign_in_at.to_formatted_s(:long) if industry.last_sign_in_at }
  column(:actions, header: "Action", html: true  ) do |industry|
    html = link_to "", admin_industry_path(industry), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View industry"
    html += link_to "", edit_admin_industry_path(industry), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit industry"
    html += link_to "", admin_industry_path(industry), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove industry", 'data-confirm' => 'Are you sure?'
    html
  end

end