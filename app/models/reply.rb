class Reply < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :comment

  validates :text, presence: true
end
