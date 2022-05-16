# encoding: UTF-8

require "spec_helper"

RSpec.describe Mt9::Transaction do
  subject(:transaction) { Mt9::Transaction.new(transaction_params) }

  let(:transaction_params) do
    {
      account_bank_number: "12",
      account_branch_number: "3113",
      account_unique_number: "0002145",
      account_suffix: account_suffix,
      transaction_code: transaction_code,
    }
  end

  let(:transaction_code) { 52 } # => "052"

  describe "#to_s" do
    context "with 2 digit account suffix" do
      let(:account_suffix) { "99" }

      it "outputs correct suffix" do
        expect(subject.to_s).to include("13123113000214599 052")
      end
    end

    context "with 3 digit account suffix" do
      let(:account_suffix) { "999" }

      it "outputs correct suffix" do
        expect(subject.to_s).to include("131231130002145999052")
      end
    end
  end
end
