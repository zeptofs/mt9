# frozen_string_literal: true

RSpec.describe MT9 do
  let(:batch_args) do
    {
      account_number: "224444777777722",
      due_date: Date.parse("4/5/2020"),
      client_short_name: "ACME Pty Ltd",
    }
  end

  it "has a version number" do
    expect(MT9::VERSION).not_to be_nil
  end

  describe "#batch_credits" do
    subject(:batch) { MT9.batch_credits(**batch_args) }
    let(:first_detail_record) { batch.detail_records[0] }
    let(:transaction2_transaction_code) { "052" }

    it "intializes an instance of MT9::CreditBatch" do
      expect(batch).to be_a(MT9::CreditBatch)
    end
  end

  describe "#batch_debits" do
    subject(:batch) { MT9.batch_debits(**batch_args) }

    it "intializes an instance of MT9::DebitBatch" do
      expect(batch).to be_a(MT9::DebitBatch)
    end
  end
end
