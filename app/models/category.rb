class Category < ActiveRecord::Base

  belongs_to :user
  has_many :posts, through: :category_posts

end
