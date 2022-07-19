# frozen_string_literal: true

require "spec_helper"

RSpec.describe MT9::DetailRecord do
  subject(:detail_record) { described_class.new(**detail_record_args) }

  let(:detail_record_args) do
    {
      account_number: account_number,
      transaction_code: transaction_code,
      amount: amount,
      this_party: this_party,
      other_party: other_party,
    }
  end

  let(:account_number) { "123113000214598" }
  let(:transaction_code) { "052" }
  let(:amount) { 1000 }
  let(:this_party) do
    {
      name: "This Party",
      code: "1234",
      alpha_reference: "alpha_ref",
      particulars: "particulars",
    }
  end
  let(:other_party) do
    {
      name: "Other Party Name, of long length"[0...20],
      code: "321987654321",
      alpha_reference: "other_alpha_ref"[0...12],
      particulars: "other_particulars"[0...12],
    }
  end

  describe "#generate" do
    context "with full account number" do
      let(:account_number) { "1231130002145990" }

      it "outputs correct row data" do
        expect(detail_record.generate).to include(
          "1312311300021459900520000001000This Party          000000000000"\
          "1234        alpha_ref   particulars  Other Party Name, of321987654321other_alpha_other_partic    \r\n",
        )
      end
    end

    context "with short suffix account number" do
      let(:account_number) { "123113000214598" }

      it "pads the space correctly" do
        expect(detail_record.generate).to include(
          "13123113000214598 0520000001000This Party          000000000000"\
          "1234        alpha_ref   particulars  Other Party Name, of321987654321other_alpha_other_partic    \r\n",
        )
      end
    end

    context "when amount is small" do
      let(:amount) { 1 }

      it "right adjusts the amount appropriately" do
        expect(detail_record.generate).to include(
          "13123113000214598 0520000000001This Party          000000000000"\
          "1234        alpha_ref   particulars  Other Party Name, of321987654321other_alpha_other_partic    \r\n",
        )
      end
    end

    context "when optional fields are blank" do
      let(:this_party) do
        {
          name: "This Party",
          code: "1234",
          alpha_reference: "",
          particulars: "",
        }
      end

      let(:other_party) do
        {
          name: "Other Party Name, of long length"[0...20],
          code: "",
          alpha_reference: "",
          particulars: "",
        }
      end

      it "outputs correct row data" do
        expect(detail_record.generate).to include(
          "13123113000214598 0520000001000This Party          000000000000"\
          "1234                                 Other Party Name, of                                        \r\n",
        )
      end
    end

    context "when optional fields are nil" do
      let(:this_party) do
        {
          name: "This Party",
          code: "1234",
          alpha_reference: nil,
          particulars: nil,
        }
      end

      let(:other_party) do
        {
          name: "Other Party Name, of long length"[0...20],
          code: nil,
          alpha_reference: nil,
          particulars: nil,
        }
      end

      it "outputs correct row data" do
        expect(detail_record.generate).to include(
          "13123113000214598 0520000001000This Party          000000000000"\
          "1234                                 Other Party Name, of                                        \r\n",
        )
      end
    end
  end
end
