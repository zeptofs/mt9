# frozen_string_literal: true

RSpec.describe MT9::Validators do
  describe "HeaderRecordContract" do
    let(:correct_header_record) do
      {
        file_type: 12,
        account_number: "123456789012345",
        due_date: Date.new(2022, 3, 12),
        client_short_name: "ACME Pty Ltd"
      }
    end

    let(:validator) { MT9::Validators::HeaderRecordContract.new }

    it "validates a correct header record" do
      expect(validator.call(correct_header_record).success?).to be(true)

      correct_header_record.delete(:client_short_name)
      expect(validator.call(correct_header_record).success?).to be(true)
    end

    describe "with an incorrect header record" do
      let(:incorrect_header_record) { correct_header_record }

      def result
        validator.call(incorrect_header_record)
      end

      it "validates file type" do
        incorrect_header_record[:file_type] = 999
        expect(result.errors[:file_type]).to eq(["must be one of: 12, 20"])
      end

      it "validates account number" do
        incorrect_header_record[:account_number] = "123456790"
        expect(result.errors[:account_number]).to eq(["must be 15 numeric characters"])

        incorrect_header_record[:account_number] = "1234567901234567"
        expect(result.errors[:account_number]).to eq(["must be 15 numeric characters"])
      end

      it "validates due date" do
        incorrect_header_record[:due_date] = "20210511"
        expect(result.errors[:due_date]).to eq(["must be a date"])
      end

      it "validates client short name" do
        incorrect_header_record[:client_short_name] = "ACME Transactions and Payments Proprietary Limited"
        expect(result.errors[:client_short_name]).to eq(["length must be within 0 - 20"])

        incorrect_header_record[:client_short_name] = nil
        expect(result.errors[:client_short_name]).to eq(["must be a string"])
      end
    end
  end
end
