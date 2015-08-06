class CommentsController < ApplicationController
  before_action :check_login
  before_action :set_trade
  before_action :set_offer
  before_action :set_comment, only: [:edit, :update]
  before_action :check_user_involved_in_trade, only: [:new, :create]
  before_action :check_user_is_poster, only: [:edit, :update]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to trade_offer_path(@trade, @offer), notice: "Comment successfully posted."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to trade_offer_path(@trade, @offer), notice: "Comment successfully updated."
    else
      render :edit
    end
  end

  private
  def set_trade
    @trade = Trade.find(params[:trade_id])
  end

  def set_offer
    @offer = Offer.find(params[:offer_id])
    if @offer.trade_id != @trade.id
      raise ActiveRecord::RecordNotFound.new("The requested offer does not exist.")
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
    if @comment.offer_id != @offer.id
      p "we're here. Are we supposed to be?"
      raise ActiveRecord::RecordNotFound.new("The requested comment does not exist.")
    end
  end

  def comment_params
    params.require(:comment).permit(:body).merge({user_id: current_user.id, offer_id: @offer.id})
  end

  def check_user_involved_in_trade
    if current_user.id != @trade.user_id && current_user.id != @offer.user_id
      authorization_failure("You must be involved in the offer to post a comment.")
    end
  end

  def check_user_is_poster
    if current_user.id != @comment.user_id
      authorization_failure
    end
  end
end
