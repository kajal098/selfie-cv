class UserMeterReport

  include Datagrid

  scope { UserMeter.order(:id) }
  scope { UserMeter.all }

  filter(:resume_per, :string, header: "Resume Per") {|value| where("resume_per ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "user_meters.id")
  column(:resume_per, header: "Resume Per", order: false, :order => "user_meters.resume_per", class: "padding_class")
  column(:updated_at) do |model|
    model.created_at.to_date
  end
  column(:actions, header: "Actions", html: true , class: "padding_class" ) do |user_meter|
    html = link_to "", admin_user_meter_path(user_meter), class: "btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View user_meter"
    html += link_to "", edit_admin_user_meter_path(user_meter), class: "btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit user_meter"
    html += link_to "", admin_user_meter_path(user_meter), class: "btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove user_meter", 'data-confirm' => 'Are you sure?'
    html
  end

end