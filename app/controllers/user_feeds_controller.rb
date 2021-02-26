class UserFeedsController < ApplicationController
  #before_action :set_user_feed, only: %i[ show edit update destroy ]
  before_action :require_login

  # GET /user_feeds or /user_feeds.json
  def index
    subscribed_to_user_ids = UserFeedSubscription.where(subscriber_user: current_user.id).pluck(:subscribed_to_user_id)
    @user_feeds = Meme.where("memes.profile_id" => subscribed_to_user_ids).with_attached_image
  end

    # GET /user_feeds/1 or /user_feeds/1.json
  def show
    render :status => 404
  end

  def new
    render :status => 404
  end
  
  def edit
    render :status => 404
  end

  def update
    render :status => 404
  end

  def destroy
    render :status => 404
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_feed
      #@user_feed = UserFeed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_feed_params
      params.fetch(:user_feed, {})
    end
end
