require "rails_helper"

# Test suite for the Note model
RSpec.describe Note, type: :model do
  # Association test
  # ensure an note record belongs to a single category record
  it { should belong_to(:category) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:text) }
end
