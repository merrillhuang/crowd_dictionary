class MostTranslatedWords
  # Method to find the words with the most submitted translations for a particular language
  def self.call(language_id)
    # Finding the words for a particular language
    origin_words_for_language = Phrase.where({ "language_id" => language_id, "origin_id" => nil })
    translations_count = {}

    # Finding all the origin words for this language and saving the number of submitted translations they have
    origin_words_for_language.each do |word|
      translations_count[word.id] = word.translations.size
    end

    # Sorts all origin words for this language by their number of submitted translations, grabbing top 5
    translations_count = translations_count.sort_by { |k, v| -v }.slice(0, 5)

    most_translated_words_ids = []

    # Only grabs the words with more than 0 translations 
    translations_count.each do |subarray|
      if subarray[1] > 0
        most_translated_words_ids.append(subarray[0])
      end
    end

    # Grabs and returns the ActiveRecord object representations of the most translated words
    most_translated_words = []
    most_translated_words_ids.each do |word_id|
      most_translated_words.append(Phrase.where({ "id" => word_id })[0])
    end

    return most_translated_words
  end
end
