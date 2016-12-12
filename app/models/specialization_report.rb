class SpecializationReport

  include Datagrid

  scope { Specialization.order(updated_at: :desc).all }
  
  # filter(:id, header: "Id") {|value| where("id ilike ?", "%#{value}%")}
  #filter(:id, header: "Personeelsnummer")
  filter(:name, :string, header: "Specialization Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "specializations.id")
  column(:name, header: "Specialization Name", :order => "specializations.name")
  column(:updated_at, html: true, header: "Updated At") { |specialization| content_tag :span, time_ago_in_words(specialization.updated_at), title: specialization.updated_at.to_formatted_s(:long) if specialization.updated_at }
  
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |specialization| content_tag :span, time_ago_in_words(specialization.last_sign_in_at), title: specialization.last_sign_in_at.to_formatted_s(:long) if specialization.last_sign_in_at }
  column(:actions, header: "Action", html: true  ) do |specialization|
    html = link_to "", admin_specialization_path(specialization), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View specialization"
    html += link_to "", edit_admin_specialization_path(specialization), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit specialization"
    html += link_to "", admin_specialization_path(specialization), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove specialization", 'data-confirm' => 'Are you sure?'
    html
  end

end