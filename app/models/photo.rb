# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  author_id      :integer
#  comments_count :integer
#  likes_count    :integer
#  location_id    :integer
#  caption        :text
#  image          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Photo < ApplicationRecord
  
  belongs_to :author, :class_name => "User"
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  belongs_to :location, :required => false
  
end
