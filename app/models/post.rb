class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  has_one_attached :image
  after_save :update_user_posts_counter

  attribute :comments_counter, default: 0
  attribute :likes_counter, default: 0

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.last(5)
  end

  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
