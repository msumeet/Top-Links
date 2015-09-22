class PagesController < ApplicationController
  def home
	   if current_user #checking if the user logged in
	  	client = get_twitter_client(session['user_token'], session['user_secret'])
		@tweets = client.home_timeline(count: 100, exclude_replies: true)
	   end
  end
end
