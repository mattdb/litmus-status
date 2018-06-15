require 'rails_helper'

RSpec.describe "Api::V1::StatusUpdate", type: :request do
  describe "PUT /api/v1/status_update/create" do

    def perform_put(data={})
      put '/api/v1/status_update/create', params: data
    end

    it "handles empty data correctly" do
      perform_put
      expect(response).to have_http_status(400)
      expect { perform_put }.to_not change(StatusUpdate, :count)
    end

    it "saves and responds when only status updated" do
      expect {perform_put(status: "UP")}.to change(StatusUpdate, :count).by(1)
      expect(response).to have_http_status(200)
    end

    it "saves and responds when only message updated" do
      expect { perform_put(message: "Maintenance ongoing!") }
        .to change(StatusUpdate, :count).by(1)
      expect(response).to have_http_status(200)
    end

    it "saves and responds when both status and message updated" do
      expect { perform_put(status: "DOWN", message: "Maintenance now!") }
        .to change(StatusUpdate, :count).by(1)
      expect(response).to have_http_status(200)
    end
  end
end
