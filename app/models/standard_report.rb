class StandardReport

  include Datagrid

  scope { Standard.order(:id) }
  scope { Standard.all }

  filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:name, header: "Name", :order => "standards.name")
  column(:created_at, html: true, header: "Created At") { |standard| content_tag :span, time_ago_in_words(standard.created_at), title: standard.created_at.to_formatted_s(:long) if standard.created_at }
  column(:updated_at, html: true, header: "Updated At") { |standard| content_tag :span, time_ago_in_words(standard.updated_at), title: standard.updated_at.to_formatted_s(:long) if standard.updated_at }
  
  column(:actions, header: "Action", html: true  ) do |standard|
    html = link_to "", admin_standard_path(standard), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View standard"
    html += link_to "", edit_admin_standard_path(standard), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit standard"
    html += link_to "", admin_standard_path(standard), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove standard", 'data-confirm' => 'Are you sure?'
    html
  end

end