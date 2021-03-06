class CourseReport

  include Datagrid

  scope { Course.order(updated_at: :desc).all }
  
  filter(:name, :string, header: "Course Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "courses.id")
  column(:name, header: "Course Name", :order => "courses.name")
  column(:updated_at, html: true, header: "Updated At") { |course| content_tag :span, time_ago_in_words(course.updated_at), title: course.updated_at.to_formatted_s(:long) if course.updated_at }
  column(:actions, header: "Action", html: true  ) do |course|
    html = link_to "", admin_course_path(course), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View course"
    html += link_to "", edit_admin_course_path(course), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit course"
    html += link_to "", admin_course_path(course), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove course", 'data-confirm' => 'Are you sure?'
    html
  end

end