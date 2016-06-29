class DeviceReport

  include Datagrid

  scope { Device.order(:id) }
  
 filter(:registration_id, :string, header: "Registration Id") {|value| where("registration_id ilike ?", "%#{value}%")}

  column(:id, header: "Id", :order => "devices.id")
  column(:uuid, header: "Uuid", :order => "devices.uuid", class: "padding_class")
  column(:token, header: "Token", :order => "devices.token")
  column(:registration_id, header: "Registration Id", :order => "devices.registration_id", class: "padding_class")
  column(:created_at, header: "Created At", :order => "devices.created_at")  
  column(:updated_at, header: "Updated At", :order => "devices.updated_at")  
  column(:actions, header: "Actions", html: true , class: "padding_class" ) do |user|
    html = link_to "", admin_devices_path(user), class: "btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove User", 'data-confirm' => 'Are you sure?'
    html
  end

end