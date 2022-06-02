# frozen_string_literal: true

RSpec.describe MT9::TrailerRecord do
  subject(:trailer_record) { described_class.new(**trailer_record_args) }

  let(:trailer_record_args) do
    {
      hash_total: hash_total,
      total_amount: total_amount,
    }
  end

  let(:hash_total) { 12_345_678_901 }
  let(:total_amount) { 9_876_543_210 }

  describe "#generate" do
    subject(:result) { trailer_record.generate }

    it "creates correctly formatted string" do
      expect(result).to eq("139912345678901      9876543210                                                           "\
        "                                                                      \r\n")
    end

    context "with a long hash total" do
      let(:hash_total) { 9_123_345_678_901 }

      it "only allows last 11 digits" do
        expect(result).to eq("139923345678901      9876543210                                                         "\
          "                                                                        \r\n")
      end
    end

    context "with a short total amount" do
      let(:total_amount) { 600 }

      it "pads to the left with 0's" do
        expect(result).to eq("139912345678901      0000000600                                                         "\
          "                                                                        \r\n")
      end
    end

    context "with invalid trailer record args" do
      let(:total_amount) { 9_999_999_999_999 }

      it "raises ValidationError" do
        expect { result }.to \
          raise_error(MT9::ValidationError, "Validation failed: total_amount must be less than or equal to 9999999999")
      end
    end
  end
end
