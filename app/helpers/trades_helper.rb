module TradesHelper
  def user_can_offer_trade?
    logged_in? && current_user.id != @trade.user_id && @trade.status == Trade::STATUSES['open'] && current_user.console == @user.console
  end
end
