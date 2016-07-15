class CourseReport

  include Datagrid

  scope { Course.order(:id) }
  scope { Course.all }

  filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "courses.id")
  column(:name, header: "Name", :order => "courses.name", class: "padding_class")
  column(:updated_at) do |model|
    model.created_at.to_date
  end
  column(:actions, header: "", html: true , class: "padding_class" ) do |course|
    html = link_to "", admin_course_path(course), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View course"
    html += link_to "", edit_admin_course_path(course), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit course"
    html += link_to "", admin_course_path(course), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove course", 'data-confirm' => 'Are you sure?'
    html
  end

end