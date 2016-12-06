json.status "Success"


if @user_like
	json.User @user_like, :id, :user_id, :like_id, :is_liked

	json.WhoLike do		    
		json.extract! User::where(id: @user_like.user_id).first, :id, :username	
		json.file User::where(id: @user_like.user_id).first.file.url	 
	end
	
	json.LikedUser do	 
		json.extract! User::where(id: @user_like.like_id).first, :id, :username	 
		json.file User::where(id: @user_like.like_id).first.file.url	 
	end

	json.count UserLike::where(like_id: @user_like.like_id).count	 
	
end

if @user_view
	json.User @user_view, :id, :user_id, :view_id

	json.WhoView do		     
		json.extract! User::where(id: @user_view.user_id).first, :id, :username	
		json.file User::where(id: @user_view.user_id).first.file.url	 
	end
	
	json.ViewedUser do	 
		json.extract! User::where(id: @user_view.view_id).first, :id, :username	 
		json.file User::where(id: @user_view.view_id).first.file.url	 
	end

	json.count UserView::where(view_id: @user_view.view_id).count

end

if @user_share
	json.User @user_share, :id, :user_id, :share_id, :share_type

	json.WhoShare do		    
		json.extract! User::where(id: @user_share.user_id).first, :id, :username	
		json.file User::where(id: @user_share.user_id).first.file.url	 
	end
	
	json.SharedUser do	 
		json.extract! User::where(id: @user_share.share_id).first, :id, :username	 
		json.file User::where(id: @user_share.share_id).first.file.url	 
	end

	json.count UserShare::where(share_id: @user_share.share_id).count

end

if @user_favourite
	json.User @user_favourite, :id, :user_id, :folder_id, :favourite_id, :is_favourited

	json.WhoFavourite do		    
		json.extract! User::where(id: @user_favourite.user_id).first, :id, :username	
		json.file User::where(id: @user_favourite.user_id).first.file.url	 
	end
	
	json.FavouritedUser do	 
		json.extract! User::where(id: @user_favourite.favourite_id).first, :id, :username	 
		json.file User::where(id: @user_favourite.favourite_id).first.file.url	 
	end

	json.count UserFavourite::where(favourite_id: @user_favourite.favourite_id).count

end

if @user_rate
	json.User @user_rate, :id, :user_id, :rate_id, :rate_type

	json.WhoRate do		    
		json.extract! User::where(id: @user_rate.user_id).first, :id, :username	
		json.file User::where(id: @user_rate.user_id).first.file.url	 
	end
	
	json.RatedUser do	 
		json.extract! User::where(id: @user_rate.rate_id).first, :id, :username	 
		json.file User::where(id: @user_rate.rate_id).first.file.url	 
	end

	json.count UserRate::where(rate_id: @user_rate.rate_id).count

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

if parsed_response

	json.id parsed_response.id
	
end
