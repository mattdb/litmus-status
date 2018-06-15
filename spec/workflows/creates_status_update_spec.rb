require "rails_helper"


RSpec.describe "CreatesStatusUpdate" do
  let(:creator) { CreatesStatusUpdate.new(
    status: status,
    message: message
  )}


  describe "failure cases" do
    it "fails when trying to create an update with neither status nor message" do
      creator = CreatesStatusUpdate.new(status: "", message: "")
      creator.create
      expect(creator).not_to be_a_success
      expect(creator.error).to eq("Must specify either a status or a message")
    end

    it "fails when trying to create an update with an invalid status" do
      creator = CreatesStatusUpdate.new(status: "UNCLEAR", message: "")
      creator.create
      expect(creator).not_to be_a_success
      expect(creator.error).to eq("Invalid Status: UNCLEAR")
    end
  end

  describe "only status provided" do
    let(:message) { "" }

    describe "Creates an update for UP status" do
      let(:status) {"UP"}
      before(:example) { creator.create }
      specify { expect(creator.update).not_to be_a_new_record }
    end
  end

  describe "both status and message provided" do
    describe "Creates an update for DOWN status with message" do
      let(:status) {"DOWN"}
      let(:message) {"Weekly Maintenance is underway."}

      before(:example) { creator.create }
      specify { expect(creator.update).not_to be_a_new_record }
    end
  end




end
