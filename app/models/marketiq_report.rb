class MarketiqReport

  include Datagrid

  scope { Marketiq.order(:id) }
  #scope { Marketiq.all }

  #filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  
  column(:question, header: "Question", :order => "marketiqs.question")
  column(:option_a, header: "option_a", :order => "marketiqs.option_a")
  column(:option_b, header: "option_b", :order => "marketiqs.option_b")
  column(:option_c, header: "option_c", :order => "marketiqs.option_c")
  column(:option_d, header: "option_d", :order => "marketiqs.option_d")
  column(:answer, header: "answer", :order => "marketiqs.answer")
  column(:created_at, html: true, header: "Created At") { |marketiq| content_tag :span, time_ago_in_words(marketiq.created_at), title: marketiq.created_at.to_formatted_s(:long) if marketiq.created_at }
  column(:updated_at, html: true, header: "Updated At") { |marketiq| content_tag :span, time_ago_in_words(marketiq.updated_at), title: marketiq.updated_at.to_formatted_s(:long) if marketiq.updated_at }
  
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |marketiq| content_tag :span, time_ago_in_words(marketiq.last_sign_in_at), title: marketiq.last_sign_in_at.to_formatted_s(:long) if marketiq.last_sign_in_at }
  column(:actions, header: "Action", html: true  ) do |marketiq|
    html = link_to "", admin_marketiq_path(marketiq), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View marketiq"
    html += link_to "", edit_admin_marketiq_path(marketiq), class: "margin_class btn btn-default btn-xs glyphicon glyphicon-edit", title: "Edit marketiq"
    html += link_to "", admin_marketiq_path(marketiq), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove marketiq", 'data-confirm' => 'Are you sure?'
    html
  end

end