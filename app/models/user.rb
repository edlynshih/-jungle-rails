class User < ActiveRecord::Base

  has_secure_password
  validates :password, length: { minimum: 8, maximum: 20 }, on: :create

  validates_presence_of :first_name, :last_name, :email, :password_confirmation

  validates_uniqueness_of :email, :case_sensitive => false

  def authenticate_with_credentials(email, password)
    @user = User.find_by email: email

    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
