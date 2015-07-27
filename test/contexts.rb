# context module to make it easy to load records for testing and development
require './test/sets/user_contexts'
require './test/sets/team_contexts'
require './test/sets/player_contexts'
require './test/sets/trade_contexts'
require './test/sets/offer_contexts'
module Contexts
  include Contexts::UserContexts
  include Contexts::TeamContexts
  include Contexts::PlayerContexts
  include Contexts::TradeContexts
  include Contexts::OfferContexts
end
