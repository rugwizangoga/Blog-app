FactoryBot.define do
  factory :like do
    association :post
    association :author, factory: :user

    after(:create) do |like|
      like.post.update(likes_counter: like.post.likes.count)
    end
  end
end
