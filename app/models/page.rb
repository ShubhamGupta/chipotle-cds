class Page < ActiveRecord::Base
  # Validations
  validates :name, :content, :site, presence: true
  validates :name, uniqueness: { scope: :site }

  # Associations
  belongs_to :site
end
