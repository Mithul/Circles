class User < ActiveRecord::Base
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :reports
  has_one :member
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def set_default_role
    self.role ||= :user
  end

  def member_role
    self.member.category
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
