class User < ActiveRecord::Base
    has_many :songs, through: :band
    has_many :bands_users 
    has_many :bands, through: :bands_users
      validates :name, presence: true
      validates :email, presence: true
end