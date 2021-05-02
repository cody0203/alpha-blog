module ApplicationHelper
  def gravatar_for(user, option = { size: 200 })
    email_address = user.email.downcase
    size = option[:size]
    hash = Digest::MD5.hexdigest(email_address)
    image_tag("https://www.gravatar.com/avatar/#{hash}?s=#{size}", class: 'rounded mx-auto d-block')
  end
end
