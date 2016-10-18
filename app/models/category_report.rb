class CategoryReport

  include Datagrid

  scope { Category.order(:id) }
  scope { Category.all }

  # filter(:id, header: "Id") {|value| where("id ilike ?", "%#{value}%")}
  #filter(:id, header: "Personeelsnummer")
  filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:name, header: "Name", :order => "categories.name")
  column(:created_at, html: true, header: "Created At") { |category| content_tag :span, time_ago_in_words(category.created_at), title: category.created_at.to_formatted_s(:long) if category.created_at }
  column(:updated_at, html: true, header: "Updated At") { |category| content_tag :span, time_ago_in_words(category.updated_at), title: category.updated_at.to_formatted_s(:long) if category.updated_at }
  
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |category| content_tag :span, time_ago_in_words(category.last_sign_in_at), title: category.last_sign_in_at.to_formatted_s(:long) if category.last_sign_in_at }
  column(:actions, header: "Action", html: true  ) do |category|
    html = link_to "", admin_category_path(category), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View category"
    html += link_to "", edit_admin_category_path(category), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit category"
    html += link_to "", admin_category_path(category), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove category", 'data-confirm' => 'Are you sure?'
    html
  end

end