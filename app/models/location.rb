# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  address    :string
#  image      :string
#  bio        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Location < ApplicationRecord
  
  has_many :photos, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  has_many :likes, :dependent => :nullify
  has_many :check_ins, :dependent => :destroy

end
