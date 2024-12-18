class PhrasesController < ApplicationController
  before_action :set_phrase, only: %i[show]

  # GET /phrases or /phrases.json
  def index
    @phrases = Phrase.all
  end

  # GET /phrases/1 or /phrases/1.json
  def show
    authorize Phrase

    if params[:target_language]
      @translations = @phrase.translations.where({ "language_id" => params[:target_language] }).page(params[:page]).per(4)
      @target_language = Language.where("id" => params[:target_language])[0].name
    else
      respond_to do |format|
        format.html { render :no_language_selected }
      end
    end
  end

  # GET /phrases/new
  def new
    @phrase = Phrase.new
  end

  # GET /phrases/1/edit
  def edit
  end

  # POST /phrases or /phrases.json
  def create
    authorize Phrase

    @phrase = Phrase.new(phrase_params)

    respond_to do |format|
      if @phrase.save
        if (@phrase.origin_id != nil)
          format.html {
            redirect_back fallback_location: phrase_path(@phrase), notice: "Phrase was successfully created."
          }
        else
          format.html { redirect_to phrase_url(@phrase), notice: "Phrase was successfully created." }
          format.json { render :show, status: :created, location: @phrase }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phrases/1 or /phrases/1.json
  def update
    respond_to do |format|
      if @phrase.update(phrase_params)
        format.html { redirect_to phrase_url(@phrase), notice: "Phrase was successfully updated." }
        format.json { render :show, status: :ok, location: @phrase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phrases/1 or /phrases/1.json
  def destroy
    @phrase.destroy!

    respond_to do |format|
      format.html { redirect_to phrases_url, notice: "Phrase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search # Could be in the model
    authorize Phrase

    @origin_word = PhraseSearch.call(params)

    if @origin_word
      respond_to do |format|
        format.html { redirect_to phrase_url(@origin_word.id, target_language: params[:target_language]) }
      end
    else
      @origin_content = params[:origin_word]
      @origin_language = Language.where("id" => params[:starting_language])[0].name
      respond_to do |format|
        format.html { render :not_found }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_phrase
    @phrase = Phrase.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def phrase_params
    params.permit(:content, :submitter_id, :language_id, :origin_id)
  end
end
