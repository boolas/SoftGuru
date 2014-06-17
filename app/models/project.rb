class Project < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :language, presence: true
end
