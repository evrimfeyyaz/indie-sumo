class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :lockable
end