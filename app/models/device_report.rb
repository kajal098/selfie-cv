class DeviceReport

  include Datagrid

  scope { Device.order(:id) }
  
 filter(:registration_id, :string, header: "Registration Id") {|value| where("registration_id ilike ?", "%#{value}%")}

  column(:id, header: "Id", :order => "devices.id")
  column(:uuid, header: "Uuid", :order => "devices.uuid", class: "padding_class")
  column(:registration_id, header: "Registration Id", order: false, :order => "devices.registration_id", class: "padding_class")
  column(:actions, header: "Actions", html: true , class: "padding_class" ) do |user|
    html = link_to "", admin_user_path(user), class: "btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove User", 'data-confirm' => 'Are you sure?'
    html
  end

end