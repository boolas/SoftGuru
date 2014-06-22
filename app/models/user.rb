class User < ActiveRecord::Base
  has_secure_password
  has_many :projects
  has_many :issues, :class_name => "Issue", :foreign_key => "user_id"
  has_many :owners, :class_name => "Issue", :foreign_key => "owner_id"

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    [first_name, last_name].join(' ')
  end
end
