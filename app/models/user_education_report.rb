class UserEducationReport

  include Datagrid

  scope { UserEducation.order(:id) }
  scope { UserEducation.all }

  # filter(:id, header: "Id") {|value| where("id ilike ?", "%#{value}%")}
  #filter(:id, header: "Personeelsnummer")
  filter(:year, :string, header: "Year") {|value| where("year ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "user_educations.id")
  column(:year, header: "Year", order: false, :order => "user_educations.year", class: "padding_class")
  column(:updated_at) do |model|
    model.created_at.to_date
  end
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |user_education| content_tag :span, time_ago_in_words(user_education.last_sign_in_at), title: user_education.last_sign_in_at.to_formatted_s(:long) if user_education.last_sign_in_at }
  column(:actions, header: "Actions", html: true , class: "padding_class" ) do |user_education|
    html = link_to "", admin_user_education_path(user_education), class: "btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View user_education"
    html += link_to "", edit_admin_user_education_path(user_education), class: "btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit user_education"
    html += link_to "", admin_user_education_path(user_education), class: "btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove user_education", 'data-confirm' => 'Are you sure?'
    html
  end

end