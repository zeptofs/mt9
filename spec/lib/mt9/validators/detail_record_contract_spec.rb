# frozen_string_literal: true

RSpec.describe MT9::Validators::DetailRecordContract do
  subject(:result) { described_class.new.call(detail_record) }

  let(:detail_record) do
    {
      account_number: "123456789012345",
      transaction_code: "052",
      this_party: this_party,
      other_party: other_party,
      amount: 1000,
    }
  end

  let(:this_party) do
    {
      name: "This Name",
      code: "This Code",
      alpha_reference: "This Alpha",
      particulars: "This Particu",
    }
  end

  let(:other_party) do
    {
      name: "Other Name",
      code: "Other Code",
      alpha_reference: "Other Alpha",
      particulars: "Other Partic",
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
      expect(result.errors[:account_number]).to eq(["must be 15 or 16 numeric characters"])
    end

    it "validates a long account number" do
      detail_record[:account_number] = "12345678901234567"
      expect(result.errors[:account_number]).to eq(["must be 15 or 16 numeric characters"])
    end

    %i[this_party other_party].each do |party|
      %i[name code alpha_reference particulars].each do |field|
        it "is invalid when #{party} #{field} contains invalid characters" do
          detail_record[party][field] = "ACM | ^ [{}]"
          expect(result.errors[party][field]).to eq(["must not contain invalid characters"])
        end
      end

      %i[name].each do |field|
        it "is invalid when #{party} #{field} contains more than 20 characters" do
          detail_record[party][field] = "This is more than twenty characters"
          expect(result.errors[party][field]).to eq(["size cannot be greater than 20"])
        end
      end

      %i[code alpha_reference particulars].each do |field|
        it "is invalid when #{party} #{field} contains more than 12 characters" do
          detail_record[party][field] = "This is more than twelve characters"
          expect(result.errors[party][field]).to eq(["size cannot be greater than 12"])
        end
      end
    end

    context "when optional fields are omitted" do
      let(:this_party) do
        {
          name: "This Name",
          code: "This Code",
        }
      end

      let(:other_party) do
        {
          name: "Other Name",
        }
      end

      it { is_expected.to be_success }
    end

    context "when optional fields are nil" do
      let(:this_party) do
        {
          name: "This Name",
          code: "This Code",
          alpha_reference: nil,
          particulars: nil,
        }
      end

      let(:other_party) do
        {
          name: "Other Name",
          code: nil,
          alpha_reference: nil,
          particulars: nil,
        }
      end

      it { is_expected.to be_success }
    end

    context "when optional fields are blank" do
      let(:this_party) do
        {
          name: "This Name",
          code: "This Code",
          alpha_reference: "",
          particulars: "",
        }
      end

      let(:other_party) do
        {
          name: "Other Name",
          code: "",
          alpha_reference: "",
          particulars: "",
        }
      end

      it { is_expected.to be_success }
    end

    it "validates amount is integer" do
      detail_record[:amount] = "12345678901234567"
      expect(result.errors[:amount]).to eq(["must be an integer"])
    end

    it "validates amount is less than max amount of 10 million" do
      detail_record[:amount] = 10_000_000_000
      expect(result.errors[:amount]).to eq(["must be less than or equal to 9999999999"])
    end

    it "validates amount is positive" do
      detail_record[:amount] = 0
      expect(result.errors[:amount]).to eq(["must be greater than 0"])
    end
  end
end
