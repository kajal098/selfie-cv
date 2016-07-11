class UserExperienceReport

  include Datagrid

  scope { UserExperience.order(:id) }
  scope { UserExperience.all }

  # filter(:id, header: "Id") {|value| where("id ilike ?", "%#{value}%")}
  #filter(:id, header: "Personeelsnummer")
  filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "user_experiences.id")
  column(:name, header: "Name", order: false, :order => "user_experiences.name", class: "padding_class")
  column(:exp_type, header: "Experience Type", :order => "user_experiences.exp_type", class: "padding_class")
  column(:start_from, header: "Start From", :order => "user_experiences.start_from", class: "padding_class")
  column(:working_till, header: "Working Till", :order => "user_experiences.working_till", class: "padding_class")
  column(:designation, header: "Designation", :order => "user_experiences.designation", class: "padding_class")
  column(:updated_at) do |model|
    model.created_at.to_date
  end
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |user_experience| content_tag :span, time_ago_in_words(user_experience.last_sign_in_at), title: user_experience.last_sign_in_at.to_formatted_s(:long) if user_experience.last_sign_in_at }
  column(:actions, header: "Actions", html: true , class: "padding_class" ) do |user_experience|
    html = link_to "", admin_user_experience_path(user_experience), class: "btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View user_experience"
    html += link_to "", edit_admin_user_experience_path(user_experience), class: "btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit user_experience"
    html += link_to "", admin_user_experience_path(user_experience), class: "btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove user_experience", 'data-confirm' => 'Are you sure?'
    html
  end

end