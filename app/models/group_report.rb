class GroupReport

  include Datagrid

  scope { Group.order(:id) }
  
  filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:name, header: "Name", :order => "groups.name")
  column(:code, header: "Code", :order => "groups.code")
  column(:deleted_from, header: "deleted_from", :order => "groups.deleted_from")
  column(:created_at, html: true, header: "Created At") { |group| content_tag :span, time_ago_in_words(group.created_at), title: group.created_at.to_formatted_s(:long) if group.created_at }
  column(:updated_at, html: true, header: "Updated At") { |group| content_tag :span, time_ago_in_words(group.updated_at), title: group.updated_at.to_formatted_s(:long) if group.updated_at }
  column(:actions, header: "Action", html: true  ) do |group|
    html = link_to "", admin_group_path(group), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View group"
    html
  end

end