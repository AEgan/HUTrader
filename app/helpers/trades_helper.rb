module TradesHelper
  def user_can_offer_trade?
    logged_in? && !current_user_posted_trade && @trade.status == Trade::STATUSES['open'] && current_user.console == @user.console
  end
end
