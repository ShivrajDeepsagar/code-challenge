class Company < ApplicationRecord
  has_rich_text :description
  validates_format_of :zip_code,
                  with: /\A\d{5}-\d{4}|\A\d{5}\z/,
                  message: "should be 12345 or 12345-1234",
                  allow_blank: true
  validates_format_of :email,
                  with: /\b[A-Z0-9._%a-z\-]+@+getmainstreet\.com\z/,
                  message: "must be a getmainstreet.com account",
                  allow_blank: true

end
