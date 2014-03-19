class Site < ActiveRecord::Base
  # Validations
  validates :name, :domain, presence: true
  validates :name, :domain, uniqueness: true

  # Associations
  has_many :pages, dependent: :destroy
end
