class LanguagesController < ApplicationController
  before_action :set_language, only: %i[show]

  # GET /languages or /languages.json
  def index
    authorize Language

    @languages = Language.page(params[:page]).per(5)
  end

  # GET /languages/1 or /languages/1.json
  def show
    authorize Language

    @most_translated_words = MostTranslatedWords.call(@language.id)

    @all_origin_words_for_language = Phrase.where({ :language_id => @language.id, :origin_id => nil }).page(params[:page]).per(5)
  end

  # GET /languages/new
  def new
    authorize Language

    @language = Language.new
  end

  # GET /languages/1/edit
  def edit
  end

  # POST /languages or /languages.json
  def create
    authorize Language
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to language_url(@language), notice: "Language was successfully created." }
        format.json { render :show, status: :created, location: @language }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /languages/1 or /languages/1.json
  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to language_url(@language), notice: "Language was successfully updated." }
        format.json { render :show, status: :ok, location: @language }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1 or /languages/1.json
  def destroy
    @language.destroy!

    respond_to do |format|
      format.html { redirect_to languages_url, notice: "Language was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    authorize Language

    @languages = Language.all
  end

  def landing
    authorize Language
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_language
    @language = Language.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def language_params
    params.require(:language).permit(:name)
  end
end
