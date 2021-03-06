class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      url = auth.info.image
      user.avatar = open(url)
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
      user.save!

      # Creates blank profile after user is saved, need to get birthday + gender info filled in
      user.create_profile(birthday: auth.info.birthday, gender: auth.info.gender)

    end
  end

  has_one :profile, dependent: :destroy
  has_many :user_chats
  has_many :chats, :through => :user_chats
  has_many :messages, :through => :chats
  accepts_nested_attributes_for :profile

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :email

  # Paperclip gem attributes for user avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :favorites, dependent: :destroy

end
