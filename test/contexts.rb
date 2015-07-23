# context module to make it easy to load records for testing and development
require './test/sets/user_contexts'
require './test/sets/team_contexts'
module Contexts
  include Contexts::UserContexts
  include Contexts::TeamContexts
end
