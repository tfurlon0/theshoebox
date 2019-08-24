# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  username        :string
#  password_digest :string
#  image           :string
#  bio             :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password
  
  
  validates(:username,
    { 
      :presence => true, 
      :uniqueness => { :case_sensitive => false } 
    }
  )
  
  
  has_many :photos, :foreign_key => "author_id", :dependent => :destroy
  has_many :comments, :foreign_key => "author_id", :dependent => :destroy
  has_many :likes, :foreign_key => "author_id", :dependent => :destroy
  has_many :check_ins, :foreign_key => "owner_id", :dependent => :destroy
  
  def locations_visited
    check_in = CheckIn.where({ :owner_id => id })
    check_in_location = check_in.pluck(:location_id)
    user_locations_array = Location.where({ :id => check_in_location })
    return user_locations_array
  end
    
end
