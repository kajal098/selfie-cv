json.status "Success"


if @user_like
	

	json.count UserLike::where(like_id: @user_like.like_id).count	 
	
end

if @notifications

json.notifications @notifications.count.times do |n|

	data =  JSON.parse(@notifications[n][5])
	json.id @notifications[n][0]
	json.photo data["who_like_photo"]
	json.msg data["msg"]
	json.name data["name"]
	json.time data["time"]
	json.who_like_id data["id"]
	json.notificationtimeago @notifications[n][14].to_i
end

end
