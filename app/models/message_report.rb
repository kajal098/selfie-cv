class MessageReport

  include Datagrid

  scope { Message.order(:id) }
  scope { Message.all }

  filter(:text, :string, header: "Text") {|value| where("text ilike ?", "%#{value}%")}
  
  column(:text, header: "Text", :order => "messages.text")
  column(:role, header: "Role", :order => "messages.role")
  column(:created_at, html: true, header: "Created At") { |message| content_tag :span, time_ago_in_words(message.created_at), title: message.created_at.to_formatted_s(:long) if message.created_at }
  column(:updated_at, html: true, header: "Updated At") { |message| content_tag :span, time_ago_in_words(message.updated_at), title: message.updated_at.to_formatted_s(:long) if message.updated_at }
  column(:actions, header: "Action", html: true  ) do |message|
    html = link_to "", admin_message_path(message), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View message"
    html += link_to "", edit_admin_message_path(message), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit message"
    html += link_to "", admin_message_path(message), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove message", 'data-confirm' => 'Are you sure?'
    html
  end

end