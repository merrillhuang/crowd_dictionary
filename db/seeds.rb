# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
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
  if Language.find_by({ :name => language }) == nil
    Language.create(name: language)
  end
end

english_phrases = ["book", "tree", "house", "water", "car"]
chinese_phrases = ["书", "树", "屋", "水", "车"]
spanish_phrases = ["libro", "árbol", "casa", "agua", "carro"]
french_phrases = ["livre", "arbre", "maison", "eau", "autocar"]
korean_phrases = ["책", "나무", "집", "물", "차"]

english_phrases.each do |phrase|
  if Phrase.find_by({ :content => phrase, :origin_id => nil }) == nil
    Phrase.create(
      content: phrase,
      language_id: Language.find_by({ :name => "English" }).id,
      origin_id: nil,
      submitter_id: nil
    )
  end
end

chinese_phrases.each do |phrase|
  if Phrase.find_by({ :content => phrase, :origin_id => nil }) == nil
    Phrase.create(
      content: phrase,
      language_id: Language.find_by({ :name => "Chinese" }).id,
      origin_id: nil,
      submitter_id: nil
    )
  end
end

spanish_phrases.each do |phrase|
  if Phrase.find_by({ :content => phrase, :origin_id => nil }) == nil
    Phrase.create(
      content: phrase,
      language_id: Language.find_by({ :name => "Spanish" }).id,
      origin_id: nil,
      submitter_id: nil
    )
  end
end

french_phrases.each do |phrase|
  if Phrase.find_by({ :content => phrase, :origin_id => nil }) == nil
    Phrase.create(
      content: phrase,
      language_id: Language.find_by({ :name => "French" }).id,
      origin_id: nil,
      submitter_id: nil
    )
  end
end

korean_phrases.each do |phrase|
  if Phrase.find_by({ :content => phrase, :origin_id => nil }) == nil
    Phrase.create(
      content: phrase,
      language_id: Language.find_by({ :name => "Korean" }).id,
      origin_id: nil,
      submitter_id: nil
    )
  end
end

if Phrase.find_by({ :content => "书",
                    :origin_id => Phrase.find_by({ :content => "book", :origin_id => nil }).id }) == nil
  Phrase.create(
    content: "书",
    language_id: Language.find_by({ :name => "Chinese" }).id,
    origin_id: Phrase.find_by({ :content => "book", :origin_id => nil }).id,
    submitter_id: User.all.sample.id
  )
end

if Phrase.find_by({ :content => "libro",
                    :origin_id => Phrase.find_by({ :content => "book", :origin_id => nil }).id }) == nil
  Phrase.create(
    content: "libro",
    language_id: Language.find_by({ :name => "Spanish" }).id,
    origin_id: Phrase.find_by({ :content => "book", :origin_id => nil }).id,
    submitter_id: User.all.sample.id
  )
end

if Phrase.find_by({ :content => "livre",
                    :origin_id => Phrase.find_by({ :content => "book", :origin_id => nil }).id }) == nil
  Phrase.create(
    content: "livre",
    language_id: Language.find_by({ :name => "French" }).id,
    origin_id: Phrase.find_by({ :content => "book", :origin_id => nil }).id,
    submitter_id: User.all.sample.id
  )
end

if Phrase.find_by({ :content => "책",
                    :origin_id => Phrase.find_by({ :content => "book", :origin_id => nil }).id }) == nil
  Phrase.create(
    content: "책",
    language_id: Language.find_by({ :name => "Korean" }).id,
    origin_id: Phrase.find_by({ :content => "book", :origin_id => nil }).id,
    submitter_id: User.all.sample.id
  )
end

if Phrase.find_by({ :content => "book",
                    :origin_id => Phrase.find_by({ :content => "书", :origin_id => nil }).id }) == nil
  Phrase.create(
    content: "book",
    language_id: Language.find_by({ :name => "English" }).id,
    origin_id: Phrase.find_by({ :content => "书", :origin_id => nil }).id,
    submitter_id: User.all.sample.id
  )
end

if Rating.count < 200
  200.times do
    rand_rating = rand(4..5)
    phrase_id = Phrase.all.sample.id
    Rating.create(
      rating_val: rand_rating,
      phrase_id: Phrase.where.not({ :origin_id => nil }).sample.id,
      submitter_id: User.all.sample.id
    )
  end
end
