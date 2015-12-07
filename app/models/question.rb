class Question < ActiveRecord::Base
  has_many :answers, dependent: :delete_all
  belongs_to :user

  validates :title, :body, :user_id, presence: true
end
