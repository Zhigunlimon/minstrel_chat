class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :user, :votable_id, presence: true
  validates :value, inclusion: { in: [true, false] }
end