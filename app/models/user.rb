class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :shipping_profiles, dependent: :destroy
  accepts_nested_attributes_for :shipping_profiles, allow_destroy: true
  has_many :orders
  has_many :quotes
  has_many :purchases
  has_many :subscribers
  



end
