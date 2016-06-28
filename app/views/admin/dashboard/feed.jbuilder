json.array! @activities do |activity| 
  json.created_at activity.created_at.to_i
  json.content render_activity(activity)
  json.owner activity.owner.to_s
end