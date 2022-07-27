# frozen_string_literal: true

RSpec.describe MT9::Validators::HeaderRecordContract do
  subject(:result) { described_class.new.call(header_record) }

  let(:header_record) do
    {
      file_type: "12",
      account_number: "123456789012345",
      due_date: Date.parse("12/03/2021"),
      client_short_name: "ACME Pty Ltd",
    }
  end

  it "validates a correct header record" do
    expect(result).to be_success
  end

  it "validates a correct header record with a blank client short name" do
    header_record[:client_short_name] = ""
    expect(result).to be_success
  end

  it "validates a correct header record with a nil client short name" do
    header_record[:client_short_name] = nil
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
      expect(result.errors[:account_number]).to eq(["length must be 15"])
    end

    it "validates a long account number" do
      header_record[:account_number] = "12345678901234567"
      expect(result.errors[:account_number]).to eq(["length must be 15"])
    end

    it "validates an non-date due date" do
      header_record[:due_date] = "20201224"
      expect(result.errors[:due_date]).to eq(["must be a date"])
    end

    it "validates a long client short name" do
      header_record[:client_short_name] = "ACME Transactions and Payments Proprietary Limited"
      expect(result.errors[:client_short_name]).to eq(["size cannot be greater than 20"])
    end

    it "validates a client short name with invalid characters" do
      header_record[:client_short_name] = "ACME|^[{}];"
      expect(result.errors[:client_short_name]).to eq(["must not contain invalid characters"])
    end
  end
end
