class User < ApplicationRecord
  has_many :events, foreign_key: "host_user_id", dependent: :destroy
  has_many :participants, foreign_key: "application_user_id", dependent: :destroy
  has_many :comments
  validates :name, presence: true
  validates :image, presence: true
  validates :username, presence: true, uniqueness: true
  mount_uploader :image, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        name: auth.info.name,
        username: auth.info.nickname,
        remote_image_url: auth.info.image
      )
    end
    return user
  end

  private

  def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
  end
end
