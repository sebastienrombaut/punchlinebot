class FindOrCreateUser
  def perform(sender_id)
    User.find_or_create_by(facebook_id: sender_id)
  end
end