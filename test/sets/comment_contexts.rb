module Contexts
  module CommentContexts
    def create_comments
      @alex_comment_on_mike_offer = FactoryGirl.create(:comment, user: @alex,
        body: "Sounds like a great trade!", offer: @mike_offer_for_alex_giroux)
      @mike_comment_on_alex_offer = FactoryGirl.create(:comment, user: @mike,
        offer: @alex_offer_for_mike_giroux)
      @mike_comment_on_mike_offer = FactoryGirl.create(:comment, user: @mike,
        offer: @mike_offer_for_alex_giroux)
      @ryan_comment_on_john_offer = FactoryGirl.create(:comment, user: @ryan,
        offer: @john_offer_for_ryan_voracek)
    end

    def destroy_comments
      @alex_comment_on_mike_offer.destroy
      @mike_comment_on_alex_offer.destroy
      @mike_comment_on_mike_offer.destroy
      @ryan_comment_on_john_offer.destroy
    end
  end
end
