# frozen_string_literal: true

RSpec.describe MT9::DebitBatch do
  subject(:batch) { described_class.new(**batch_args) }

  let(:batch_args) do
    {
      account_number: "224444777777722",
      due_date: Date.parse("4/5/2020"),
      client_short_name: "ACME Pty Ltd",
    }
  end

  let(:transaction1_args) do
    {
      account_number: "123456789012345",
      amount: 1000,
      this_party: {
        name: "This Name",
        code: "This Code",
        alpha_reference: "This Alpha",
        particulars: "This Particulars",
      },
      other_party: {
        code: "Other Code",
        alpha_reference: "Other Alpha",
        particulars: "Other Particulars",
      },
    }
  end

  let(:transaction2_args) do
    {
      account_number: "1100001234567890",
      transaction_code: "000",
      amount: 5000,
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
    }
  end

  context "when adding a transaction" do
    let(:first_detail_record) { batch.detail_records[0] }

    it "automatically sets transaction code and other party's name" do
      batch.add_transaction(**transaction1_args)

      expect(first_detail_record.transaction_code).to eq("000")
      expect(first_detail_record.other_party_name).to eq("ACME Pty Ltd")
    end
  end

  context "with a couple of transactions" do
    before do
      batch.add_transaction(**transaction1_args)
      batch.add_transaction(**transaction2_args)
    end

    describe "#generate" do
      let(:generated_string) { batch.generate }

      it "generates correctly formatted string" do
        expect(generated_string).to eq(File.read("spec/fixtures/mt9_direct_debits.txt"))
      end
    end
  end
end
