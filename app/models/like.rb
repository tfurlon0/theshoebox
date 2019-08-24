# == Schema Information
#
# Table name: likes
#
#  id          :integer          not null, primary key
#  author_id   :integer
#  photo_id    :integer
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Like < ApplicationRecord

  belongs_to :author, :class_name => "User"
  belongs_to :photo, :required => false
  belongs_to :location, :required => false

end
