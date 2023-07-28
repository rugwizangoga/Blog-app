class User < ApplicationRecord
  has_many :posts, foreign_key: 'Author_id'
  has_many :likes, foreign_key: 'User_id'
  has_many :comments, foreign_key: 'User_id'
end
