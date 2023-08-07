class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :likes, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_one_attached :photo

  attribute :posts_counter, default: 0
  attribute :role, :string

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :set_posts_counter

  def set_posts_counter
    self.posts_counter = posts.count
  end

  def admin?
    role == 'admin'
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
