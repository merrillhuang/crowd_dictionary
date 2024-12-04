class PhraseSearch
  def self.call(params)
    origin_content = params[:origin_word]
    origin_word = Phrase.where({"content" => origin_content, "origin_id" => nil, "language_id" => params[:starting_language]})
    if origin_word.empty?
      return nil
    end
    return origin_word[0]
  end
end
