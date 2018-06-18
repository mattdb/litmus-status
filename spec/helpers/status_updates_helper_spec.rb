require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StatusUpdatesHelper. For example:
#
# describe StatusUpdatesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StatusUpdatesHelper, type: :helper do

  describe ".describe_status" do
    it "returns 'up' when true" do
      expect(helper.describe_status(true)).to eq('up')
    end

    it "returns 'down' when false" do
      expect(helper.describe_status(false)).to eq('down')
    end

    it "returns 'unknown' when nil" do
      expect(helper.describe_status(nil)).to eq('unknown')
    end
  end
end
