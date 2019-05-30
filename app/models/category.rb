class Category < ApplicationRecord
  has_many :notes, dependent: :destroy

  validates_presence_of :name
end
