class GroupUserReport

  include Datagrid

  scope { GroupUser.order(updated_at: :desc).all }
  
  #filter(:name, :string, header: "Name") {|value| where("name ilike ?", "%#{value}%")}
  filter(:user_id, :enum, header: "User", select: ->{ User.pluck(:first_name, :id) }, prompt: "Select something")
  filter(:group_id, :enum, header: "Group", select: ->{ Group.pluck(:name, :id) }, prompt: "Select something")
  
  column(:user_id, header: "User Id", :order => "groups.user_id")

  column(:user_id, header: "User", :order => "group_users.user_id",) do |model|
    model.user.first_name
  end

  column(:group_id, header: "Group Id", :order => "groups.group_id")

  column(:group_id, header: "Group", :order => "group_users.group_id",) do |model|
    model.group.name
  end
  column(:status, header: "Status", :order => "groups.status")

  column(:admin, header: "Admin", :order => "groups.admin")

  column(:updated_at, html: true, header: "Updated At") { |group| content_tag :span, time_ago_in_words(group.updated_at), title: group.updated_at.to_formatted_s(:long) if group.updated_at }
  column(:actions, header: "Action", html: true  ) do |group|
    html = link_to "", admin_group_path(group), class: "margin_class btn btn-primary btn-xs glyphicon glyphicon-eye-open", title: "View group"
    html
  end

end