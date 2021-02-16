class UserFeedSubscriptionsController < ApplicationController
  before_action :set_user_feed_subscription, only: %i[ show edit update destroy ]

  # GET /user_feed_subscriptions or /user_feed_subscriptions.json
  def index
    @user_feed_subscriptions = UserFeedSubscription.all
  end

  # GET /user_feed_subscriptions/1 or /user_feed_subscriptions/1.json
  def show
  end

  # GET /user_feed_subscriptions/new
  def new
    @user_feed_subscription = UserFeedSubscription.new
  end

  # GET /user_feed_subscriptions/1/edit
  def edit
  end

  # POST /user_feed_subscriptions or /user_feed_subscriptions.json
  def create
    @user_feed_subscription = UserFeedSubscription.new(user_feed_subscription_params)

    respond_to do |format|
      if @user_feed_subscription.save
        format.html { redirect_to @user_feed_subscription, notice: "User feed subscription was successfully created." }
        format.json { render :show, status: :created, location: @user_feed_subscription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_feed_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_feed_subscriptions/1 or /user_feed_subscriptions/1.json
  def update
    respond_to do |format|
      if @user_feed_subscription.update(user_feed_subscription_params)
        format.html { redirect_to @user_feed_subscription, notice: "User feed subscription was successfully updated." }
        format.json { render :show, status: :ok, location: @user_feed_subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_feed_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_feed_subscriptions/1 or /user_feed_subscriptions/1.json
  def destroy
    @user_feed_subscription.destroy
    respond_to do |format|
      format.html { redirect_to user_feed_subscriptions_url, notice: "User feed subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_feed_subscription
      @user_feed_subscription = UserFeedSubscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_feed_subscription_params
      params.fetch(:user_feed_subscription, {})
    end
end
