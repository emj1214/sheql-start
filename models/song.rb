class Song < ActiveRecord::Base
    belongs_to :band
    has_many :users, through: :band
    
     validates :band, presence: true
     validates :content, presence: true
     validates :date, presence: true
end