module ApplicationHelper

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    if user.image
      user.image
    else
      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
    end
  end

  def options_for_experience_type
    [['Arts & Design', 'Arts_Design'],
    ['Fashion', 'Fashion'],
    ['Sports', 'Sports'],
    ['Wellness', 'Wellness'],
    ['Nature', 'Nature'],
    ['Food & Drink', 'Food_Drink'],
    ['Lifestyle', 'Lifestyle'],
    ['History', 'History'],
    ['Music', 'Music'],
    ['Business', 'Business'],
    ['Nightlife', 'Nightlife']]
  end

end
