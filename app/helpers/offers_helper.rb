module OffersHelper
  def user_can_post_comment?
    (logged_in?) && (current_user.id == @trade.user_id || current_user.id == @offer.user_id)
  end

  def user_posted_comment?(comment)
    (logged_in?) && (current_user.id == comment.user_id)
  end
end
