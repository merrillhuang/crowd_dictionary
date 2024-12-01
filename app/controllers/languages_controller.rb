class LanguagesController < ApplicationController
  before_action :set_language, only: %i[ show edit update destroy ]

  # GET /languages or /languages.json
  def index
    @languages = Language.all
  end

  # GET /languages/1 or /languages/1.json
  def show
    origin_words_for_language = Phrase.where({"language_id" => @language.id, "origin_id" => nil})
    translations_count = {}
    
    origin_words_for_language.each do |word|
      translations_count[word.id] = word.translations.size
    end
    
    translations_count = translations_count.sort_by {|k, v| -v}.slice(0, 5)

    most_translated_words_ids = []

    translations_count.each do |subarray|
      most_translated_words_ids.append(subarray[0])
    end

    @most_translated_words = []
    most_translated_words_ids.each do |word_id|
      @most_translated_words.append(Phrase.where({"id" => word_id})[0])
    end
  end

  # GET /languages/new
  def new
    @language = Language.new
  end

  # GET /languages/1/edit
  def edit
  end

  # POST /languages or /languages.json
  def create
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

  def landing
    @languages = Language.all
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
