class User < ApplicationRecord

  has_secure_password
  has_secure_token :confirmation_token

  validates :username,
    format: { with: /\A[a-zA-Z0-9]{2,20}\z/, message: 'must only contain alphanumerical characters' },
    uniqueness: { case_sensitive: false, message: 'already taken' }
  
  validates :email,
    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ },
    uniqueness: { case_sensitive: false }

    def to_session
      { user_id: id }
    end
end
