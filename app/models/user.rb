class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile

  validates_presence_of :email, :first_name, :last_name
  validates_uniqueness_of :email

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :favorites, dependent: :destroy

end
