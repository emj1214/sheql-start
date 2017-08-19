get '/' do
  @user = User.find(session[:current_user_id])
  @songs = Song.all
  erb :"home"
end

get '/users' do
  @users = User.all
  erb :"users/index"
end

get '/songs' do
  @songs = Song.all
  erb :"songs/index"
end

get '/users/:id' do
  id = params[:id].to_i
  @user = User.find(id)
  @bands = @user.bands
  erb :"users_id"
end

get '/bands' do 
  @bands = Band.all
  erb :"bands/index"
end

get "/options" do
  erb :"options"
end

get "/create_band" do
  @user = User.find(session[:current_user_id])
  erb :"create_band"
end

get "/edit_band" do
  user = User.find(session[:current_user_id])
  @bands = user.bands
  erb :"edit_band"
end

get "/edit_band/:id" do
  band_id = params[:id].to_i
  @band = Band.find(band_id)
  @band_members = @band.users
  erb :"editing_band"
end

get "/users/:user_id/remove_from_:id" do
  band_id = params[:id].to_i
  @band = Band.find(band_id)
  user_id = params[:user_id].to_i
  @user = User.find(user_id)
  erb :"removing_user"
end

post "/removing/:user_id/:band_id" do
  user_id = params[:user_id].to_i
  band_id = params[:band_id].to_i
  bands_users = BandsUser.where(["user_id = ? and band_id = ?", user_id, band_id])
  bands_users.each do |bu|
    bu.destroy
  end
  redirect to("/stuff_was_saved")
end

get "/join_band" do
  erb :"join_band"
end
##TODO and this erb too

get "/going_to_band_profile" do
  @user = User.find(session[:current_user_id])
  @bands = @user.bands
  erb :"going_to_band_profile"
end

get "/band_profile/:user_id/:band_id" do
  user_id = params[:user_id].to_i
  band_id = params[:band_id].to_i
  @band = Band.find(band_id)
  @songs = @band.songs
  erb :"band_profile"
end

get "/going_to_add_song" do
  user = User.find(session[:current_user_id])
  @user = user
  @bands = user.bands
  erb :"going_to_add_song"
end

get "/add_song/:id" do
  user = User.find(session[:current_user_id])
  @user = user
  @bands = user.bands
  band_id = params[:id].to_i
  @band = Band.find(band_id)
  erb :"add_song"
end

#/new_song_added/<%= @user.id %>/<%= band.id %>

post "/new_song_added/:user_id/:band_id" do
  user_id = params[:user_id].to_i
  band_id = params[:band_id].to_i
  @user = User.find(user_id)
  @band = Band.find(band_id)
  @song = Song.create(name: params["song_name"], content: params["content"], date: Date.today, band: @band)
  @user.bands << @band
  @user.save
  redirect to("/stuff_was_saved")
end

get "/about" do
  erb :"about"
end

post "/headed_home/:id" do 
  user_id = params[:id].to_i
  @user = User.find(user_id)
  @band = Band.create(name: params["band_name"])
  @user.bands << @band
  @user.save
  
  if params[:email1] != ""
    user_email = params[:email1]
    @next_user1 = User.find_by email: user_email
    @next_user1.bands << @band
    @next_user1.save
  end
  if params[:email2] != "" 
    user_email = params[:email2]
    @next_user2 = User.find_by email: user_email
    @next_user2.bands << @band
    @next_user2.save
  end
  if params[:email3] != ""
    user_email = params[:email3]
    @next_user3 = User.find_by email: user_email
    @next_user3.bands << @band
    @next_user3.save
  end
  if params[:email4] != ""
    user_email = params[:email4]
    @next_user4 = User.find_by email: user_email
    @next_user4.bands << @band
    @next_user4.save
  end
  if params[:email5] != "" 
    user_email = params[:email5]
    @next_user5 = User.find_by email: user_email
    @next_user5.bands << @band
    @next_user5.save
  end
  if params[:email6] != "" 
    user_email = params[:email6]
    @next_user6 = User.find_by email: user_email
    @next_user6.bands << @band
    @next_user6.save
  end
  if params[:email7] != ""
    user_email = params[:email7]
    @next_user7 = User.find_by email: user_email
    @next_user7.bands << @band
    @next_user7.save
  end
  redirect to("/stuff_was_saved")
end

get "/band_members/:id" do
  band_id = params[:id].to_i
  @band = Band.find(band_id)
  @band_members = @band.users
  erb :"band_members"
end

##https://github.com/Gmfholley/sinatra-app/blob/hearting_tweets/views/tweets/new.erb

get "/stuff_was_saved" do
  erb :"stuff_was_saved"
end

get "/band_profile/:id" do 
  band_id = params[:id].to_i
  @band = Band.find(band_id)
  @songs = @band.songs
  erb :"band_profile"
end
  