class UserReport

  include Datagrid

  scope { User.where.not(role: 0).order(updated_at: :desc).all }
  
  #filter(:role, :string, header: "Role") {|value| where("CAST(role AS text) ilike ?", "%#{value}%")}
  filter(:username, :string, header: "Username") {|value| where("username ilike ?", "%#{value}%")}
  filter(:role, :enum, header: "Role", select: ->{ User.roles})
  filter(:email, :string, header: "Email") {|value| where("username ilike ?", "%#{value}")}
  
  column(:id, header: "Id",  :order => "users.id")
  column(:role, header: "Role",  :order => "users.role")
  column(:username, header: "Username", :order => "users.username")
  column(:email, header: "Email",  :order => "users.email")
  # column(:contact_number, header: "Number") do |model|
  #   if model.role == 'Company'
  #     model.company_contact
  #   else
  #     model.contact_number
  #   end
  # end
  column(:updated_at, html: true, header: "Updated At") { |user| content_tag :span, time_ago_in_words(user.updated_at), title: user.updated_at.to_formatted_s(:long) if user.updated_at }
  column(:actions, header: "Action", html: true  ) do |user|
    html = link_to "", admin_user_path(user), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View User"
    html
  end

end

