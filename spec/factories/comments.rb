FactoryBot.define do
  factory :comment do
    association :post
    association :author, factory: :user

    after(:create) do |comment|
      comment.post.update(comments_counter: comment.post.comments.count)
    end

    after(:destroy) do |comment|
      comment.post.update(comments_counter: comment.post.comments.count)
    end
  end
end
