class MostTranslatedWords
  # Could use some comments
  def self.call(language_id)
    origin_words_for_language = Phrase.where({ "language_id" => language_id, "origin_id" => nil })
    translations_count = {}

    origin_words_for_language.each do |word|
      translations_count[word.id] = word.translations.size
    end

    translations_count = translations_count.sort_by { |k, v| -v }.slice(0, 5)

    most_translated_words_ids = []

    translations_count.each do |subarray|
      if subarray[1] != 0
        most_translated_words_ids.append(subarray[0])
      end
    end

    most_translated_words = []
    most_translated_words_ids.each do |word_id|
      most_translated_words.append(Phrase.where({ "id" => word_id })[0])
    end

    return most_translated_words
  end
end
