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
      expect(result).to eq("12123456789012345 251220       ACME Pty Ltd                                                                                                                     \r\n") # rubocop:disable Layout/LineLength
    end
  end

  it "raises ValidationError with an incorrect header record" do
    header_record[:file_type] = "999"

    expect { described_class.new(**header_record) }.to \
      raise_error(MT9::ValidationError, "Validation failed: file_type must be one of: 12, 20")
  end
end
