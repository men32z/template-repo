class User < ApplicationRecord
  belongs_to :user_status, foreign_key: "status_id"

  before_save :downcase_email

  validates :first_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }


  def fullname
    "#{self.first_name} #{self.last_name}"
  end

  def downcase_email
    self.email = email.downcase
  end
end
