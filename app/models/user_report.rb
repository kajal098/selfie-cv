class UserReport

  include Datagrid

  scope { User.order(:id) }
  scope { User.where(role: 0) }

  # filter(:id, header: "Id") {|value| where("id ilike ?", "%#{value}%")}
  #filter(:id, header: "Personeelsnummer")
  filter(:username, :string, header: "Username") {|value| where("username ilike ?", "%#{value}%")}
  filter(:email, :string, header: "E-mail") {|value| where("email ilike ?", "%#{value}%")}

  column(:id, header: "Id", order: false)
  column(:username, header: "Username", order: false)
  column(:email, header: "E-mail", order: false)
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |user| content_tag :span, time_ago_in_words(user.last_sign_in_at), title: user.last_sign_in_at.to_formatted_s(:long) if user.last_sign_in_at }
  column(:actions, header: "Actions", html: true) do |user|
    html = link_to "", edit_admin_user_path(user), class: "btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit User"
    html += link_to "", admin_user_path(user), class: "btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove User", 'data-confirm' => 'Are you sure?'
    html
  end

end