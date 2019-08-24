# == Schema Information
#
# Table name: check_ins
#
#  id          :integer          not null, primary key
#  owner_id    :integer
#  location_id :integer
#  image       :string
#  caption     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CheckIn < ApplicationRecord
  
  belongs_to :owner, :class_name => "User"
  belongs_to :location

end
