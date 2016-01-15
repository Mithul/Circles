class User < ActiveRecord::Base
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :reports
  has_one :member
  has_many :uploads
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def set_default_role
    self.role ||= :user
  end

  def member_role
    self.member.category if self.member
  end

  def authority? object
    if !(self.role == :admin or self.role == 'admin')
      if object.class.to_s == 'Comment'
        return object.user == self
      else
        return (self.member.circles.include?(object.circle) and self.member.category==:kore)
      end
    else
      return true
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
