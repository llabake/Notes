require "rails_helper"

RSpec.describe Category, type: :model do
  # Association test
  # ensure Category model has a 1:m relationship with the Item model
  it { should have_many(:notes).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  # it { should validate_presence_of(:note_id) }
end
