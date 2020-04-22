class UserAddress < ApplicationRecord
  belongs_to :user

  validates_presence_of :nickname,
                        :address,
                        :city,
                        :state,
                        :zip

  enum nickname: ['home', 'work', 'office', 'other']

end
