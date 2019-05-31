require "rails_helper"

RSpec.describe "Notes API", type: :request do
  let!(:category) { create(:category) }
  let!(:notes) { create_list(:note, 20, category_id: category.id) }
  let(:category_id) { category.id }
  let(:note_id) { notes.first.id }

  describe "GET /notes" do
    before { get "/notes" }

    it "return a list of notes" do
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /notes/:id
  describe "GET /notes/:id" do
    before { get "/notes/#{note_id}" }

    context "when the record exists" do
      it "returns the note" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(note_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:note_id) { 372 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  # Test suite for POST /notes
  describe "POST /notes" do
    # valid payload
    let(:valid_attributes) do
      { title: "Learn JS", text: "JS is a must learn,
    well even ruby", category_id: category_id }
    end

    context "when the request is valid" do
      before { post "/notes", params: valid_attributes }

      it "creates a note" do
        expect(json["title"]).to eq("Learn JS")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post "/notes", params: { title: "Today at Andela" } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).
          to match(
            /Validation failed: Category must exist, Text can't be blank/,
          )
      end
    end
  end

  # Test suite for PUT /notes/:id
  describe "PUT /notes/:id" do
    let(:valid_attributes) { { title: "Yesterday at Andela" } }

    context "when the record exists" do
      before { put "/notes/#{note_id}", params: valid_attributes }

      it "updates the record" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /notes/:id
  describe "DELETE /notes/:id" do
    before { delete "/notes/#{note_id}" }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
