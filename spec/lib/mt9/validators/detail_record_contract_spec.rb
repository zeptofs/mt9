# frozen_string_literal: true

RSpec.describe MT9::Validators::DetailRecordContract do
  subject(:result) { described_class.new.call(detail_record) }

  let(:detail_record) do
    {
      account_number: "123456789012345",
      transaction_code: "052",
      this_party: {
        name: "This Name",
        code: "This Code",
        alpha_reference: "This Alpha",
        particulars: "This Particulars",
      },
      other_party: {
        name: "Other Name",
        code: "Other Code",
        alpha_reference: "Other Alpha",
        particulars: "Other Particulars",
      },
      amount: 1000,
    }
  end

  it "validates a correct detail record" do
    expect(result).to be_success
  end

  describe "with an incorrect detail record" do
    it "validates an invalid transaction code" do
      detail_record[:transaction_code] = "123"
      expect(result.errors[:transaction_code]).to eq(["must be one of: 000, 051, 052"])
    end

    it "validates a reserved bank code" do
      detail_record[:account_number] = "991234567890123"
      expect(result.errors[:account_number]).to eq(["must not start with a reserved bank code"])
    end

    it "validates a short account number" do
      detail_record[:account_number] = "123456790"
      expect(result.errors[:account_number]).to eq(["length must be within 15 - 16"])
    end

    it "validates a long account number" do
      detail_record[:account_number] = "12345678901234567"
      expect(result.errors[:account_number]).to eq(["length must be within 15 - 16"])
    end

    %i[this_party other_party].each do |party|
      %i[name code alpha_reference particulars].each do |field|
        it "is invalid when #{party} #{field} contains invalid characters" do
          detail_record[party][field] = "ACME | ^ [{}]"
          expect(result.errors[party][field]).to eq(["must not contain invalid characters"])
        end
      end
    end

    it "validates amount is integer" do
      detail_record[:amount] = "12345678901234567"
      expect(result.errors[:amount]).to eq(["must be an integer"])
    end

    it "validates amount is less than max amount of 10 million" do
      detail_record[:amount] = 10_000_000_000
      expect(result.errors[:amount]).to eq(["must be less than 10000000000"])
    end

    it "validates amount is positive" do
      detail_record[:amount] = 0
      expect(result.errors[:amount]).to eq(["must be greater than 0"])
    end
  end
end
