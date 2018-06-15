require 'rails_helper'

RSpec.describe StatusUpdate, type: :model do

  describe "empty StatusUpdate" do
    let(:update) { StatusUpdate.new }
    specify { expect(update).to_not be_valid }
  end

  describe "status-only StatusUpdate" do
    let(:update) { StatusUpdate.new(is_up: true) }
    specify { expect(update).to be_valid }
  end

  describe "message-only StatusUpdate" do
    let(:update) { StatusUpdate.new(message: "Maintenance is still going!") }
    specify { expect(update).to be_valid }
  end

  describe "StatusUpdate with both status and message" do
    let(:update) { StatusUpdate.new(is_up: false, message: "Maintenance!") }
    specify { expect(update).to be_valid }
  end
end
