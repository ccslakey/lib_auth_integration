require 'bcrypt'

class User < ActiveRecord::Base
  BCrypt::Engine.cost = 12


  validates_confirmation_of :password
  validates :email, :password_digest, presence: true, uniqueness: true
  
  has_many :users_books
  has_many :books, through: :users_books

  def authenticate(unencrypted_password)
    secure_password = BCrypt::Password.new(self.password_digest)
    if secure_password == unencrypted_password
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
    #raise scope of password to instance
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def password
    #get password, equivalent to `attr_reader :password`
    @password
  end

  def self.confirm(email_param, password_param)
    user = User.find_by({email: email_param})
    user.authenticate(password_param)
  end

end