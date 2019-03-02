class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  include Friendships
  
  validates_presence_of   :nickname, :email
  validates_presence_of   :password, :on => :create
  validates_uniqueness_of :nickname
  validates_uniqueness_of :email, case_sensitive: false

  has_many :bookmarks

  def self.by_login(login)
    u = User.arel_table
    where(u[:nickname].eq(login).or(u[:email].eq(login)))
  end
end
