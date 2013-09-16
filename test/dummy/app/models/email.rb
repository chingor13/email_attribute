class Email < ActiveRecord::Base

  email_address_attribute :from
  email_address_list_attribute :to

  validates :from, email: {message: "custom message"}
  validates :to, email: {message: "another message"}

  validates :subject, :body, presence: true

end