class User < ApplicationRecord

  before_save { self.email = email.downcase if email.present? }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, length: { minimum: 6 }, presence: true, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
      presence: true,
      uniqueness: { case_sensitive: false },
      length: { minimum: 3, maximum: 254 }


  has_secure_password

end
