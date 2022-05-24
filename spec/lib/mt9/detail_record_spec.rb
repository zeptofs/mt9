# frozen_string_literal: true

require "spec_helper"

RSpec.describe MT9::DetailRecord do
  subject(:transaction) { MT9::DetailRecord.new(**transaction_params) }

  let(:transaction_params) do
    {
      account_number: account_number,
      transaction_code: transaction_code,
      amount: amount,
      this_party: {
        name: "This Party",
        code: "1234",
        alpha_reference: "alpha_ref",
        particulars: "particulars",
      },
      other_party: {
        name: "Other Party Name, of long length",
        code: "3219876543210",
        alpha_reference: "other_alpha_ref",
        particulars: "other_particulars",
      },
    }
  end

  let(:account_number) { "123113000214598" }
  let(:transaction_code) { "052" }
  let(:amount) { 1000 }

  describe "#generate" do
    context "full account number" do
      let(:account_number) { "1231130002145990" }

      it "outputs correct suffix" do
        expect(subject.generate).to include(
          "1312311300021459900520000001000This Party          000000000000"\
          "1234        alpha_ref   particulars  Other Party Name, of321987654321other_alpha_other_partic    \n")
      end
    end

    context "short suffix account number" do
      let(:account_number) { "123113000214598" }

      it "pads the space correctly" do
        expect(subject.generate).to include(
          "13123113000214598 0520000001000This Party          000000000000"\
          "1234        alpha_ref   particulars  Other Party Name, of321987654321other_alpha_other_partic    \n")
      end
    end

    context "when given transaction_code as an int" do
      let(:transaction_code) { 51 }

      it "pads the space correctly" do
        expect(subject.generate).to include(
          "13123113000214598 0510000001000This Party          000000000000"\
          "1234        alpha_ref   particulars  Other Party Name, of321987654321other_alpha_other_partic    \n")
      end
    end
  end
end
