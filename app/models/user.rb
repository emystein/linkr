class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  include Friendships

  validates_presence_of :nickname, :email
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :nickname
  validates_uniqueness_of :email, case_sensitive: false

  has_many :bookmarks
  has_many :tag_bundles

  def self.by_login(login)
    u = User.arel_table
    where(u[:nickname].eq(login).or(u[:email].eq(login)))
  end

  def self.from_omniauth(access_token)
    info = access_token['info']

    user = User.where(email: info['email']).first

    unless user
      user = User.create(nickname: info['name'],
                         email: info['email'],
                         password: Devise.friendly_token[0, 20]
      )
    end

    user
  end
end
