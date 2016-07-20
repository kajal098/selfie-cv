class UserReport

  include Datagrid

  scope { User.where.not(role: 0).all }
  
  filter(:username, :string, header: "Username") {|value| where("username ilike ?", "%#{value}%")}
  filter(:email, :string, header: "E-mail") {|value| where("email ilike ?", "%#{value}%")}
  
  column(:id, header: "Id",  :order => "users.id", class: "padding_class")
  column(:role, header: "Role",  :order => "users.role", class: "padding_class")
  column(:username, header: "Username", :order => "users.username", class: "padding_class")
  column(:email, header: "E-mail",  :order => "users.email", class: "padding_class")
  column(:updated_at) do |model|
    model.created_at.to_date
  end
  column(:file, :html => true, class: 'padding_class',) do |model|
        image_tag model.file.url,  :size => "20x20"
      end
  column(:actions, header: "", html: true , class: "padding_class" ) do |user|
    html = link_to "", admin_user_path(user), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View User"
    html += link_to "", admin_user_path(user), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove User", 'data-confirm' => 'Are you sure?'
    html
  end

end

