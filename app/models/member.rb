class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_one :profile
  has_many :locations
  has_many :reservations
  
  accepts_nested_attributes_for :profile, allow_destroy: true

  validates_presence_of :name

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |member|
      member.email = auth.info.email
      member.password = Devise.friendly_token[0,20]
      # add empty string in case there is no name from the provider
      member.name = auth.info.name || ""       
    end
  end
end
