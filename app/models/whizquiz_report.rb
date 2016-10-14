class WhizquizReport

  include Datagrid

  scope { Whizquiz.order(:updated_at => "desc")}

  #filter(:id, :string, header: "Id") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "whizquizzes.id")
  column(:question, header: "Question", :order => "whizquizzes.question")
  column(:answer, header: "Answer", :order => "whizquizzes.answer")
  column(:status, header: "Status", :order => "whizquizzes.status")
  column(:created_at, html: true, header: "Created At") { |whizquiz| content_tag :span, time_ago_in_words(whizquiz.created_at), title: whizquiz.created_at.to_formatted_s(:long) if whizquiz.created_at }
  column(:updated_at, html: true, header: "Updated At") { |whizquiz| content_tag :span, time_ago_in_words(whizquiz.updated_at), title: whizquiz.updated_at.to_formatted_s(:long) if whizquiz.updated_at }
  column(:actions, header: "Action", html: true  ) do |whizquiz|
    html = link_to "", admin_whizquiz_path(whizquiz), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View whizquiz"
    html += link_to "", edit_admin_whizquiz_path(whizquiz), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit whizquiz"
    html += link_to "", admin_whizquiz_flop_path(whizquiz), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-plus", title: "Flop whizquiz"
    html
  end

end