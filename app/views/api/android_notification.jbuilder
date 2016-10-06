json.status "Success"

if @user_like
	json.count UserLike::where(like_id: @user_like.like_id).count	 	
end

json.notifications @notifications.count.times do |n|

	data =  JSON.parse(@notifications[n][5])
	json.id @notifications[n][0]
	json.title data["title"]
	json.msg data["message"]
	json.icon data["icon"]
	json.notificationtimeago @notifications[n][14].to_i
end