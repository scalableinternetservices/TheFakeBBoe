class UserFeedsController < ApplicationController
  before_action :set_user_feed, only: %i[ show edit update destroy ]

  # GET /user_feeds or /user_feeds.json
  def index
    @user_feeds = UserFeed.all
  end

  # GET /user_feeds/1 or /user_feeds/1.json
  def show
  end

  # GET /user_feeds/new
  def new
    @user_feed = UserFeed.new
  end

  # GET /user_feeds/1/edit
  def edit
  end

  # POST /user_feeds or /user_feeds.json
  def create
    @user_feed = UserFeed.new(user_feed_params)

    respond_to do |format|
      if @user_feed.save
        format.html { redirect_to @user_feed, notice: "User feed was successfully created." }
        format.json { render :show, status: :created, location: @user_feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_feeds/1 or /user_feeds/1.json
  def update
    respond_to do |format|
      if @user_feed.update(user_feed_params)
        format.html { redirect_to @user_feed, notice: "User feed was successfully updated." }
        format.json { render :show, status: :ok, location: @user_feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_feeds/1 or /user_feeds/1.json
  def destroy
    @user_feed.destroy
    respond_to do |format|
      format.html { redirect_to user_feeds_url, notice: "User feed was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_feed
      @user_feed = UserFeed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_feed_params
      params.fetch(:user_feed, {})
    end
end
