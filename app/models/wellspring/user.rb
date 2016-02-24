module Wellspring
  class User < ActiveRecord::Base
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :password, presence: { unless: :persisted? }, length: { minimum: 6 }, allow_nil: true

    before_create { generate_token(:auth_token) }

    private

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Wellspring::User.exists?(column => self[column])
    end
  end
end
