class Band < ActiveRecord::Base
    has_many :songs
    has_many :bands_users
    has_many :users, through: :bands_users
  validates :name, presence: true

end


##TODO make user have many bands
## that can be done with a new table called UserBand that has user_id and band_id
## but don't add this until after class over


# band
#@user.bands << band
## secret: bands_user object

## user
## @band.users << user