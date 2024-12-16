desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  p "Creating sample data"

  if Rails.env.development?
    Rating.delete_all
    Phrase.delete_all
    Language.delete_all
    User.delete_all
  end

  usernames = Array.new

  usernames << "alice"
  usernames << "bob"

  8.times do
    usernames << Faker::Name.first_name
  end

  usernames.each do |username|
    User.create(
      email: "#{username}@example.com",
      password: "password",
      username: username.downcase
    )
  end

  languages = ["English", "Chinese", "Spanish", "French", "Korean"]

  languages.each do |language|
    curr_lang = Language.create(
      name: language
    )
  end

  english_phrases = ["book", "tree", "house", "water", "car"]
  chinese_phrases = ["书", "树", "屋", "水", "车"]
  spanish_phrases = ["libro", "árbol", "casa", "agua", "carro"]
  french_phrases = ["livre", "arbre", "maison", "eau", "autocar"]
  korean_phrases = ["책", "나무", "집", "물", "차"]

  translated_phrases = [chinese_phrases, spanish_phrases, french_phrases, korean_phrases]

  users = User.all
  database_languages = Language.all

  english_phrases.each do |phrase|
    Phrase.create(
      content: phrase,
      language_id: database_languages[0].id,
      origin_id: nil,
      submitter_id: nil
    )
  end

  phrases = Phrase.all

  translated_phrases.each.with_index(1) do |language, index|
    language.each do |phrase|
      curr = Phrase.create(
        content: phrase,
        language_id: database_languages[index].id,
        origin_id: rand() < 0.3 ? nil : phrases.sample.id,
        submitter_id: users.sample.id
      )
    end
  end

  phrases = Phrase.all

  200.times do
    rand_rating = rand(1..5)
    rand_phrase = rand(1..25)
    rating = Rating.create(
      rating_val: rand_rating, # This is rating_val according to the schema. Make sure your code works before commiting.
      phrase_id: phrases.sample.id,
      submitter_id: users.sample.id
    )
  end

  p "There are now #{User.count} users."
  p "There are now #{Language.count} languages."
  p "There are now #{Phrase.count} phrases."
  p "There are now #{Rating.count} ratings."
end
