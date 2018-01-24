class Message < ApplicationRecord

  VALID_CAPTCHA_REGEX = /\Aw68hp\z/i
  validates_presence_of :name, :email, :message, :captcha
  validates :captcha, format: {with: VALID_CAPTCHA_REGEX}
  
end
