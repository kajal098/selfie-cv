class QuickMessageReport

  include Datagrid

  scope { QuickMessage.order(:id) }
  scope { QuickMessage.all }

  filter(:text, :string, header: "Text") {|value| where("text ilike ?", "%#{value}%")}
  
  column(:text, header: "Text", :order => "quick_messages.text")
  column(:role, header: "Role", :order => "quick_messages.role")
  column(:updated_at, html: true, header: "Updated At") { |quick_message| content_tag :span, time_ago_in_words(quick_message.updated_at), title: quick_message.updated_at.to_formatted_s(:long) if quick_message.updated_at }
  column(:actions, header: "Action", html: true  ) do |quick_message|
    html = link_to "", admin_quick_message_path(quick_message), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View quick message"
    html += link_to "", edit_admin_quick_message_path(quick_message), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit quick message"
    html += link_to "", admin_quick_message_path(quick_message), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove quick message", 'data-confirm' => 'Are you sure?'
    html
  end

end