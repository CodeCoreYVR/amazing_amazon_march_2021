# rails g factory_bot:model news_article
FactoryBot.define do
  factory :news_article do
    sequence(:title) { |n| Faker::Movies::StarWars.character + " #{n}"}
    description { Faker::Hacker.say_something_smart }
    user
  end
end
