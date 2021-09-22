class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    # .strip is to ensure that any leading or trailing space will be ignored
    email_fixed = email.strip.downcase
    # The .where method below compares the formatted email with an email
    # in database that has ALSO been downcased.
    user = where('LOWER(email) LIKE ?', email_fixed).first

    user if user && user.authenticate(password)
  end
end
