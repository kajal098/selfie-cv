class DeviceReport

  include Datagrid

  scope { Device.order(:id) }
  
  filter(:registration_id, :string, header: "Registration Id") {|value| where("registration_id ilike ?", "%#{value}%")}
  filter(:uuid, :string, header: "Uuid") {|value| where("CAST(uuid AS text) ilike ?", "%#{value}%")}
  filter(:token, :string, header: "Token") {|value| where("CAST(token AS text) ilike ?", "%#{value}%")}
  
  column(:uuid, header: "Uuid", :order => "devices.uuid")
  column(:token, header: "Token", :order => "devices.token")
  column(:registration_id, header: "Registration Id", :order => "devices.registration_id")
  column(:updated_at, html: true, header: "Updated At") { |device| content_tag :span, time_ago_in_words(device.updated_at), title: device.updated_at.to_formatted_s(:long) if device.updated_at }
  
  column(:actions, header: "Action", html: true ) do |user|
    html = link_to "", admin_device_path(user), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove User", 'data-confirm' => 'Are you sure?'
    html
  end

end

