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


  describe ".currently_up?" do
    describe "when no status records exist" do
      before(:each) { create(:status_update, is_up: nil, completeness: :only_message)}

      specify { expect(StatusUpdate.currently_up?).to be_nil }
    end

    describe "when down status record exists" do
      before(:each) { create(:status_update, is_up: false)}

      specify { expect(StatusUpdate.currently_up?).to be(false) }
    end

    describe "when multiple status records exist" do
      it "reports the most recent status" do
        create(:status_update, is_up: true, created_at: 1.hour.from_now)
        create(:status_update, is_up: false)

        expect(StatusUpdate.currently_up?).to be(true)
      end
    end
  end

  describe ".recent_messages" do
    describe "when no status records exist" do
      before(:each) { create(:status_update, message: nil, completeness: :only_status)}

      specify { expect(StatusUpdate.recent_messages).to match_array([]) }
    end

    describe "when StatusUpdate with message exists" do
      let!(:update) { create(:status_update, message: "Maintenance!")}

      specify { expect(StatusUpdate.recent_messages.map(&:message)).to match_array(["Maintenance!"]) }
      specify { expect(StatusUpdate.recent_messages.length).to be(1) }
    end

    describe "when multiple message records exist" do
      it "limits records found" do
        create_list(:status_update, 11, completeness: :only_message)
        create(:status_update, completeness: :both)

        expect(StatusUpdate.recent_messages.length).to be(10)
      end
    end
  end

end
