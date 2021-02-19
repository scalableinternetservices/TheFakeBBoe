class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy addFriend ]

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    @friends = @profile.friends
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # Adds an existing profile as a friend
  def addFriend
    # First, check if the profile exists
    nameToAdd = params[:addFriendForm][:name]
    if (Profile.exists?(name: nameToAdd)) 
      profileToAdd = Profile.find_by_name(nameToAdd)
      
      @profile.friends << profileToAdd.clone()
      #raise profileToAdd.name + " " + @profile.friends[0].name + " " + @profile.friends[1].name + " " + @profile.friends[2].name + " " + @profile.friends[3].name + " " + @profile.friends[4].name + " " + @profile.friends[5].name + " " + @profile.friends[6].name + " " + @profile.friends[7].name + " " + @profile.friends[-1].name


      respond_to do |format|
        format.html { redirect_to @profile, notice: "Profile was successfully befriended" }
        format.json { render :show, status: :ok, location: @profile }
      end
    else
      respond_to do |format|
        format.html { redirect_to @profile, notice: "Name does not exist" }
        format.json { render :show, status:  :unprocessable_entity, location: @profile }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      # TODO: use current logged in user
      params.require(:profile).permit(:name, :age, :location, :occupation, :bio)
    end
end
