# frozen_string_literal: true

RSpec.describe MT9::Validators::HeaderRecordContract do
  subject(:result) { described_class.new.call(header_record) }

  let(:header_record) do
    {
      file_type: "12",
      account_number: "123456789012345",
      due_date: "120321",
      client_short_name: "ACME Pty Ltd"
    }
  end

  it "validates a correct header record" do
    expect(result).to be_success
  end

  it "validates with a 16 digit account number" do
    header_record[:account_number] = "1234567890123456"
    expect(result).to be_success
  end

  it "validates a correct header record with no client short name" do
    header_record.delete(:client_short_name)
    expect(result).to be_success
  end

  describe "with an incorrect header record" do
    it "validates an invalid file type" do
      header_record[:file_type] = "999"
      expect(result.errors[:file_type]).to eq(["must be one of: 12, 20"])
    end

    it "validates a reserved bank code" do
      header_record[:account_number] = "991234567890123"
      expect(result.errors[:account_number]).to eq(["must not start with a reserved bank code"])
    end

    it "validates a short account number" do
      header_record[:account_number] = "123456790"
      expect(result.errors[:account_number]).to eq(["must be 15 or 16 numeric characters"])
    end

    it "validates a long account number" do
      header_record[:account_number] = "12345678901234567"
      expect(result.errors[:account_number]).to eq(["must be 15 or 16 numeric characters"])
    end

    it "validates a short due date" do
      header_record[:due_date] = "213"
      expect(result.errors[:due_date]).to eq(["must be 6 numeric characters"])
    end

    it "validates a long due date" do
      header_record[:due_date] = "20210511"
      expect(result.errors[:due_date]).to eq(["must be 6 numeric characters"])
    end

    it "validates a long client short name" do
      header_record[:client_short_name] = "ACME Transactions and Payments Proprietary Limited"
      expect(result.errors[:client_short_name]).to eq(["length must be within 0 - 20"])
    end

    it "validates a nil client short name" do
      header_record[:client_short_name] = nil
      expect(result.errors[:client_short_name]).to eq(["must be a string"])
    end
  end
end