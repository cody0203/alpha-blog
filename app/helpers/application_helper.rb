module ApplicationHelper
  def gravatar_for(user, option = { size: 200 })
    email_address = user.email.downcase
    size = option[:size]
    hash = Digest::MD5.hexdigest(email_address)
    image_tag("https://www.gravatar.com/avatar/#{hash}?s=#{size}", class: 'rounded mx-auto d-block')
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
