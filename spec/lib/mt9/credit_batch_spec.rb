# frozen_string_literal: true

RSpec.describe MT9::CreditBatch do
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
      amount: transaction1_amount,
      this_party: {
        name: "This Name",
        code: "This Code",
      },
    }
  end
  let(:transaction1_amount) { 1000 }

  let(:transaction2_args) do
    {
      account_number: "1100001234567890",
      transaction_code: transaction2_code,
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
  let(:transaction2_code) { "052" }

  context "when adding a transaction" do
    let(:first_detail_record) { batch.detail_records[0] }

    it "automatically sets transaction code and other party's name" do
      batch.add_transaction(**transaction1_args)

      expect(first_detail_record.transaction_code).to eq("051")
      expect(first_detail_record.other_party_name).to eq("ACME Pty Ltd")
    end

    it "allows overriding the transaction code and other party's name" do
      batch.add_transaction(**transaction2_args)

      expect(first_detail_record.transaction_code).to eq("052")
      expect(first_detail_record.other_party_name).to eq("Other Name")
    end

    context "with an invalid transaction code" do
      let(:transaction2_code) { "000" }

      it "raises an ArgumentError" do
        expect { batch.add_transaction(**transaction2_args) }.to \
          raise_error(ArgumentError, "Invalid transaction code for MT9::CreditBatch")
      end
    end

    context "that exceeds the batch max amount" do
      let(:transaction1_amount) { 9_999_999_999 }

      before do
        batch.add_transaction(**transaction1_args)
      end

      it "raises a RuntimeError" do
        expect { batch.add_transaction(**transaction2_args) }.to \
          raise_error(RuntimeError, "Batch total amount exceeds max amount: 9999999999 cents")
      end
    end
  end

  context "with a couple of transactions" do
    before do
      batch.add_transaction(**transaction1_args)
      batch.add_transaction(**transaction2_args)
    end

    it "hash total should be sum of branch and unique numbers from each transaction" do
      expect(batch.hash_total).to eq(
        Integer(transaction1_args[:account_number][2..12]) + Integer(transaction2_args[:account_number][2..12]),
      )
    end

    describe "#generate" do
      let(:generated_string) { batch.generate }

      it "generates correctly formatted string" do
        expect(generated_string).to eq(File.read("spec/fixtures/mt9_direct_credits.txt"))
      end
    end
  end
end
