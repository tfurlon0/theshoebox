# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  text        :text
#  author_id   :integer
#  location_id :integer
#  photo_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ApplicationRecord

  belongs_to :author, :class_name => "User"
  belongs_to :photo, :required => false
  belongs_to :location, :required => false

end
