class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable, :confirmable,
         :lockable, :registerable, :omniauthable,
         omniauth_providers: %i[facebook]

  validates_uniqueness_of :username, case_sensitive: false
  validates_presence_of :username
  validates_length_of :username, maximum: 24

  def self.from_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_initialize do |user|
      user.email    = auth['info']['email']
      user.password = Devise.friendly_token[0, 20]
      user.name     = auth['info']['name']

      user.skip_confirmation! if user.email.present?
    end
  end

  def to_param
    username
  end
end