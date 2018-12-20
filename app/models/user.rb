class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable, :confirmable,
         :lockable, :registerable

  validates_presence_of :username
  validates_length_of :username, maximum: 64
end
