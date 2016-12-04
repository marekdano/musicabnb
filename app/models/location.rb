class Location < ApplicationRecord
  belongs_to :member, dependent: :destroy

  validates_presence_of :title, 
                        :description, 
                        :address_1, 
                        :address_2,
                        :city,
                        :state,
                        :postcode,
                        :musical_instrument,
                        :night_rate,
                        :guests,  
                        :member_id

end
