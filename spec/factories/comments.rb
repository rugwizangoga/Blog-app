FactoryBot.define do
  factory :comment do
    association :post
    association :author, factory: :user
    text { Faker::Lorem.paragraph } # Add this line to set the comment text

    after(:create) do |comment|
      comment.post.update(comments_counter: comment.post.comments.count)
    end

    after(:destroy) do |comment|
      comment.post.update(comments_counter: comment.post.comments.count)
    end
  end
end
