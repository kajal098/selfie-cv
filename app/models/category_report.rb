class CategoryReport

  include Datagrid

  scope { Category.order(updated_at: :desc).all }
  
  filter(:name, :string, header: "Category Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:id, header: "Id", :order => "categories.id")
  column(:name, header: "Category Name") do |model|
    model.name.capitalize
  end
  column(:updated_at, html: true, header: "Updated At") { |category| content_tag :span, time_ago_in_words(category.updated_at), title: category.updated_at.to_formatted_s(:long) if category.updated_at }
  
  column(:actions, header: "Action", html: true  ) do |category|
    html = link_to "", admin_category_path(category), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View category"
    html += link_to "", edit_admin_category_path(category), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit category"
    html += link_to "", admin_category_path(category), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove category", 'data-confirm' => 'Are you sure?'
    html
  end

end