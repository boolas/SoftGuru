class User < ActiveRecord::Base
  has_secure_password
  has_many :projects

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    [first_name, last_name].join(' ')
  end
end
