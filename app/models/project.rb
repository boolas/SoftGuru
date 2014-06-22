class Project < ActiveRecord::Base
  belongs_to :user
  has_many :issues

  validates :name, presence: true, uniqueness: true
  validates :language, presence: true
end
