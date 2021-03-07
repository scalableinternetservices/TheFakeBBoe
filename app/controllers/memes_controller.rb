class MemesController < ApplicationController
  before_action :set_meme, only: %i[show edit update destroy]
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :require_owner, only: %i[edit update destroy]
  skip_before_action :verify_authenticity_token

  # GET /memes or /memes.json
  def index
    @memes = Meme.all
  end

  def browse_by_tag
    tag = params['tag']
    # p tag
    # p !Tag.exists?(name: tag)
    unless Tag.exists?(name: tag)
      render json: { error: 'not-found' }.to_json, status: 404
      return
    end
    @memes = Meme.joins(:tags).where('tags.name' => tag) # .with_attached_image

    if @memes.empty?
      render json: { error: 'not-found' }.to_json, status: 404
      return
    end
  end

  # GET /memes/1 or /memes/1.json
  def show; end

  # GET /memes/new
  def new
    @profiles = current_user.profiles
    @meme = Meme.new
    response.set_header("AVAILABLE_PROFILE", @profiles.first.id)
  end

  # GET /memes/1/edit
  def edit
    @profiles = current_user.profiles
  end

  # POST /memes or /memes.json
  def create
    @profiles = current_user.profiles
    meme_p, tags_p = meme_params
    if current_user.profiles.where(id: meme_p[:profile_id]).empty?
      flash.now[:error] = 'You are not the owner of that profile.'
      render('errors/error_403', status: :forbidden) && return
    end
    respond_to do |format|
      save_result = Meme.transaction do
        tags = get_or_create_tags(tags_p)
        @meme = Meme.new(meme_p)
        @meme.tags = tags
        @meme.save
      end

      if save_result
        format.html { redirect_to @meme, notice: 'Meme was successfully created.' }
        format.json { render :show, status: :created, location: @meme }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memes/1 or /memes/1.json
  def update
    @profiles = current_user.profiles
    respond_to do |format|
      meme_p, tags_p = meme_params
      if current_user.profiles.where(id: meme_p[:profile_id]).empty?
        flash.now[:error] = 'You are not the owner of that profile.'
        render('errors/error_403', status: :forbidden) && return
      end
      tags = get_or_create_tags(tags_p)
      if @meme.update(meme_p.merge(tags: tags))
        # meme.image.attach(params[:image]) if params.key?(:image)
        format.html { redirect_to @meme, notice: 'Meme was successfully updated.' }
        format.json { render :show, status: :ok, location: @meme }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memes/1 or /memes/1.json
  def destroy
    @meme.destroy
    respond_to do |format|
      format.html { redirect_to memes_url, notice: 'Meme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meme
    @meme = Meme.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def meme_params
    # TODO: allow profile selection
    meme_p = params.require(:meme)
                   .permit(:title, :image, :profile_id).except(:tag_field)
    tag_p = params.require(:meme).permit(:tag_field).fetch(:tag_field, '')
                  .split(/\s*,\s*/)
                  .map(&:strip)
                  .filter { |s| !s.empty? }
    [meme_p, tag_p]
  end

  def get_or_create_tags(tag_names)
    return [] if tag_names.empty?

    # insert tags, doing nothing if already exists
    tag_cols = tag_names.to_a.map do |n|
      { name: n, created_at: Time.now, updated_at: Time.now }
    end
    Tag.insert_all(tag_cols)

    # query tags for the ones we just inserted
    Tag.where(name: tag_names).to_a
  end

  def require_owner
    if @meme.user.id != current_user.id
      flash.now[:error] = 'You are not the creator of that meme.'
      render('errors/error_403', status: :forbidden) && return
    end
  end

  def require_profile_owner(profile_id); end
end
