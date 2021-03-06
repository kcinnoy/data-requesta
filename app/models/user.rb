class User < ActiveRecord::Base
  has_secure_password

  has_many :posts
  has_many :categories
  has_many :comments

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
