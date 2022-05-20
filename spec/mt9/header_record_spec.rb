# frozen_string_literal: true

RSpec.describe MT9::HeaderRecord do
  let(:header_record) do
    {
      file_type: "12",
      account_number: "123456789012345",
      due_date: "251220",
      client_short_name: "ACME Pty Ltd"
    }
  end

  describe "when generating header record" do
    subject(:result) { described_class.new(**header_record).generate }

    it "creates correctly formatted string" do
      expect(result).to eq("12123456789012345 251220       ACME Pty Ltd                                                                                                                     \r\n")
    end

    it "fails with invalid file type" do
      header_record[:file_type] = 999

      expect { result }.to raise_error(ArgumentError, "Invalid filetype. Must be one of the following: 12, 20")
    end

    it "fails with a short account number" do
      header_record[:account_number] = "123456790"
      expect { result }.to raise_error(ArgumentError, "Invalid length (length must be 15)")
    end

    it "fails with a long account number" do
      header_record[:account_number] = "1234567901234567"
      expect { result }.to raise_error(ArgumentError, "Invalid length (length must be 15)")
    end

    it "fails with a invalid due date" do
      header_record[:due_date] = "20210501"
      expect { result }.to raise_error(ArgumentError, "Invalid length (length must be 6)")
    end
  end
end
