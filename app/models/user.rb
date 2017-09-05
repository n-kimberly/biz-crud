class User < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :sponsored_posts, dependent: :destroy

  before_save {
    self.email = email.downcase if email.present?
  }

  before_save {
    adjusted_name = []
    self.name.to_s.split.each do |str|
      adjusted_name << str.capitalize
    end
    self.name = adjusted_name.join(" ")
  }

  before_save {
    self.role ||= :member
  }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, length: { minimum: 6 }, presence: true, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
      presence: true,
      uniqueness: { case_sensitive: false },
      length: { minimum: 3, maximum: 254 }


  has_secure_password

  enum role: [:member, :mod, :admin]

end
