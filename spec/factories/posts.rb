FactoryBot.define do
  factory :post do
    association :author, factory: :user
    title { Faker::Lorem.sentence(word_count: 5) }
    comments_counter { 0 }
    likes_counter { 0 }

    trait :with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
        post.reload
      end
    end

    trait :with_likes do
      transient do
        likes_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:like, evaluator.likes_count, post: post)
        post.reload
      end
    end
  end
end
