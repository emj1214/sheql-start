def set_user_session
  session[:access_token] = user_credentials.access_token
  session[:refresh_token] = user_credentials.refresh_token
  session[:expires_in] = user_credentials.expires_in
  session[:issued_at] = user_credentials.issued_at
end

get '/login' do
  # Page where user can log in
  #I changed '/login' to just '/' so it would automatically take me to the login page. 
  #change back to '/login' if the above doesn't work
  "Hi! Welcome to WeB3!  <a href='/authenticate' > Log in Using Google </a>"
end

get '/authenticate' do
  # Request authorization
  redirect user_credentials.authorization_uri.to_s, 303
end

get '/authenticated' do
  # Exchange token with Google
  user_credentials.code = params[:code] if params[:code]
  # get access token
  user_credentials.fetch_access_token!

   # set user tokens into session
  set_user_session

  # use user tokens to request their profile information
  info_service = Google::Apis::Oauth2V2::Oauth2Service.new
  info = info_service.get_userinfo(options: { authorization: user_credentials.access_token })

  # save profile information to database
  user = User.find_or_initialize_by(email: info.email)
  user.picture = info.picture
  user.name = "#{info.given_name} #{info.family_name}"
  user.save
  session[:current_user_id] = user.id

  redirect to('/')
end

get '/logout' do
  # Clear the session and redirect to where user can log in
  session.clear
  redirect to('/login')
end