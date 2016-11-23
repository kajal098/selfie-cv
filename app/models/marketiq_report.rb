class MarketiqReport

  include Datagrid

  scope { Marketiq.order(:id) }
  
filter(:industry_id, :enum, header: "Industry", select: ->{ Industry.pluck(:name, :id) })

filter(:specialization_id, :enum, header: "Specialization", select: ->{ Specialization.pluck(:name, :id) })

filter(:subject, :string, header: "Subject") {|value| where("subject ilike ?", "%#{value}%")}

filter(:award_name, :string, header: "Award Name") {|value| where("award_name ilike ?", "%#{value}%")}
  column(:industry_id, header: "Industry") do |model|
    model.industry_id ? model.industry.name : ""
  end
  column(:specialization_id, header: "Spe.") do |model|
    model.specialization_id ? model.specialization.name : ""
  end
  column(:subject, header: "Subject", :order => "marketiqs.subject")
  column(:award_name, header: "Award Name", :order => "marketiqs.award_name")
  column(:question, header: "Question", :order => "marketiqs.question")
  column(:option_a, header: "A", :order => "marketiqs.option_a")
  column(:option_b, header: "B", :order => "marketiqs.option_b")
  column(:option_c, header: "C", :order => "marketiqs.option_c")
  column(:option_d, header: "D", :order => "marketiqs.option_d")
  column(:answer, header: "answer", :order => "marketiqs.answer")
  column(:role, header: "Role", :order => "marketiqs.role")
  column(:updated_at, html: true, header: "Updated At") { |marketiq| content_tag :span, time_ago_in_words(marketiq.updated_at), title: marketiq.updated_at.to_formatted_s(:long) if marketiq.updated_at }
  
  #column(:last_sign_in_at, html: true, header: "Laatste aanmelding") { |marketiq| content_tag :span, time_ago_in_words(marketiq.last_sign_in_at), title: marketiq.last_sign_in_at.to_formatted_s(:long) if marketiq.last_sign_in_at }
  column(:actions, header: "Action", html: true  ) do |marketiq|
    html = link_to "", admin_marketiq_path(marketiq), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View marketiq"
    html += link_to "", admin_marketiq_path(marketiq), class: "margin_class btn btn-danger btn-xs glyphicon glyphicon-remove", method: :delete, title: "Remove marketiq", 'data-confirm' => 'Are you sure?'
    html
  end

end