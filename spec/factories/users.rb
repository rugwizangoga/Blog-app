# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { 'user_photo.avif' }
    bio { Faker::Lorem.paragraph }
    posts_counter { 0 }

    transient do
      posts_count { 3 }
      likes_count { 3 }
      comments_count { 3 }
    end

    trait :with_posts do
      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, author: user)
        user.reload
      end
    end

    trait :with_likes do
      after(:create) do |user, evaluator|
        create_list(:like, evaluator.likes_count, user:)
        user.reload
      end
    end

    trait :with_comments do
      after(:create) do |user, evaluator|
        create_list(:comment, evaluator.comments_count, author: user)
        user.reload
      end
    end
  end
end
