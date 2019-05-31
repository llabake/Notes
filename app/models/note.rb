class Note < ApplicationRecord
  belongs_to :category

  validates_presence_of :title, :text
end
