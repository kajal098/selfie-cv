class DeviceReport

  include Datagrid

  scope { Device.order(:id) }
  
  filter(:registration_id, :string, header: "Registration Id") {|value| where("registration_id ilike ?", "%#{value}%")}
  #filter(:uuid, :string, header: "Uuid") {|value| where("uuid ilike ?", "%#{value}%")}

  
  column(:uuid, header: "Uuid", :order => "devices.uuid", class: "padding_class")
  column(:token, header: "Token", :order => "devices.token")
  column(:registration_id, header: "Registration Id", :order => "devices.registration_id", class: "padding_class")
  column(:updated_at, html: true, header: "Updated At") { |device| content_tag :span, time_ago_in_words(device.updated_at), title: device.updated_at.to_formatted_s(:long) if device.updated_at }
  
  column(:actions, header: "", html: true , class: "margin_class padding_class" ) do |user|
    html = link_to "", admin_device_path(user), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove User", 'data-confirm' => 'Are you sure?'
    html
  end

end