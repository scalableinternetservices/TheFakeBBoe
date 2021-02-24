class MemesController < ApplicationController
  before_action :set_meme, only: %i[ show edit update destroy ]
  before_action :require_login, only: %i[ new create edit update destroy ]
  before_action :require_owner, only: %i[ edit update destroy ]

  # GET /memes or /memes.json
  def index
    @memes = Meme.all
  end

  def browse_by_tag()
    tag = params["tag"]
    #p tag
    #p !Tag.exists?(name: tag)
    if (!Tag.exists?(name: tag))
      render :json => {:error => "not-found"}.to_json, :status => 404
      return
    end
    @memes = Meme.joins(:tags).where('tags.name' => tag).with_attached_image

    if @memes.length == 0
      render :json => {:error => "not-found"}.to_json, :status => 404
      return  
    end 



  end

  # GET /memes/1 or /memes/1.json
  def show
  end

  # GET /memes/new
  def new
    @meme = Meme.new
  end

  # GET /memes/1/edit
  def edit
  end

  # POST /memes or /memes.json
  def create
    @meme = Meme.new(meme_params)

    respond_to do |format|
      if @meme.save
        format.html { redirect_to @meme, notice: "Meme was successfully created." }
        format.json { render :show, status: :created, location: @meme }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memes/1 or /memes/1.json
  def update
    respond_to do |format|
      if @meme.update(meme_params)
        if params.key?(:image)
          meme.image.attach(params[:image])
        end
        format.html { redirect_to @meme, notice: "Meme was successfully updated." }
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
      format.html { redirect_to memes_url, notice: "Meme was successfully destroyed." }
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
      params.require(:meme).permit(:title, :image).merge({:user_id => current_user.id})
    end

    def require_owner
      if @meme.user_id != current_user.id
        flash.now[:error] = "You are not the creator of that meme."
        render "errors/error_403", status: :forbidden and return
      end
    end
end
