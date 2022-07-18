# frozen_string_literal: true

RSpec.describe MT9::HeaderRecord do
  subject(:header_record) { described_class.new(**header_record_args) }

  let(:header_record_args) do
    {
      file_type: "12",
      account_number: account_number,
      due_date: due_date,
      client_short_name: client_short_name,
    }
  end

  let(:account_number) { "123456789012345" }
  let(:due_date) { Date.parse("25/12/2020") }
  let(:client_short_name) { "ACME Pty Ltd" }

  describe "#generate" do
    subject(:result) { header_record.generate }

    it "creates correctly formatted string" do
      expect(result).to eq("12123456789012345 20201225     ACME Pty Ltd                                               "\
        "                                                                      \r\n")
    end

    context "with no client short name" do
      let(:client_short_name) { "" }

      it "creates correctly formatted string" do
        expect(result).to eq("12123456789012345 20201225                                                              "\
          "                                                                        \r\n")
      end
    end

    context "with a nil client short name" do
      let(:client_short_name) { nil }

      it "creates correctly formatted string" do
        expect(result).to eq("12123456789012345 20201225                                                              "\
          "                                                                        \r\n")
      end
    end

    context "with invalid header record args" do
      let(:account_number) { "1231231243123" }

      it "raises ValidationError" do
        expect { result }.to \
          raise_error(MT9::ValidationError, "Validation failed: account_number length must be 15")
      end
    end
  end
end
