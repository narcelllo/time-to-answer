module UsersBackofficeHelper
  def profile_img
    return "user_img.png" unless current_user&.profile_img&.attached?

    current_user.profile_img
  end
end
