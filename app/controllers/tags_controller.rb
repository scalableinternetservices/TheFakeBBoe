class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  # GET /tags or /tags.json
  def index
    @tags = Tag.all.page params[:page]
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.fetch(:tag, {})
    end
end
