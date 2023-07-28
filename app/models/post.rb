class Post < ApplicationRecord
  belongs_to :Author, class_name: 'User'
  has_many :likes, foreign_key: 'Post_id'
  has_many :comments, foreign_key: 'Post_id'
end
