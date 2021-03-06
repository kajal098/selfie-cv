class ChatReport

  include Datagrid
  scope { Chat.order(:id) }
  
  column(:id, header: "id", :order => "chats.id")
  column(:quick_msg, header: "Quick Message", :order => "chats.quick_msg")
  column(:receiver_id, header: "Receiver", :order => "chats.receiver_id")
  column(:sender_id, header: "Sender", :order => "chats.sender_id")
  column(:updated_at, html: true, header: "Updated At") { |chat| content_tag :span, time_ago_in_words(chat.updated_at), title: chat.updated_at.to_formatted_s(:long) if chat.updated_at }
  column(:actions, header: "Action", html: true  ) do |chat|
    html = link_to "", admin_chat_path(chat), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View chat"
    html += link_to "", edit_admin_chat_path(chat), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit chat"
    html += link_to "", admin_chat_path(chat), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove chat", 'data-confirm' => 'Are you sure?'
    html
  end

end