class AvgUserRating
  def self.call(user)
    sum = 0
    num_ratings = 0
    avg_rating = 0
    user.translated_words.each do |phrase|
      phrase.ratings.each do |rating|
        sum += rating.rating_val.to_f
        num_ratings += 1
      end
    end
    
    if num_ratings > 0
      avg_rating = (sum / num_ratings).truncate(2)
    end

    return avg_rating
  end
end
