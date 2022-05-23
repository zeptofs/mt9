# frozen_string_literal: true

RSpec.describe Fixy::Formatter::Numeric do
  subject(:test_instance) { test_class.new }

  let(:test_class) do
    Class.new(Object) do
      include Fixy::Formatter::Numeric
    end
  end

  describe "#format_numeric" do
    it "formats with correct string" do
      expect(test_instance.format_numeric("1234", 4)).to eq("1234")
    end

    it "raises error with invalid strings" do
      expect do
        test_instance.format_numeric("12345", 4)
      end.to raise_error(ArgumentError, "Invalid length (length must be 4)")

      expect do
        test_instance.format_numeric("123", 4)
      end.to raise_error(ArgumentError, "Invalid length (length must be 4)")

      expect do
        test_instance.format_numeric("123a", 4)
      end.to raise_error(ArgumentError, "Invalid input (only digits are accepted)")
    end
  end

  describe "#format_file_type" do
    it "formats with correct string" do
      expect(test_instance.format_file_type("12", 2)).to eq("12")
      expect(test_instance.format_file_type("20", 2)).to eq("20")
    end

    it "raises error with invalid string" do
      expect do
        test_instance.format_file_type("99", 2)
      end.to raise_error(ArgumentError, "Invalid filetype. Must be one of the following: 12, 20")
    end
  end

  describe "#format_account_number" do
    it "formats with correct strings" do
      expect(test_instance.format_account_number("123456789012345", 16)).to eq("123456789012345 ")

      expect(test_instance.format_account_number("1234567890123456", 16)).to eq("1234567890123456")
    end

    it "raises error with invalid inputs" do
      expect do
        test_instance.format_account_number("12345678901234", 14)
      end.to raise_error(ArgumentError, "Length of field needs to be 16")

      expect do
        test_instance.format_account_number("12345678901234567", 17)
      end.to raise_error(ArgumentError, "Length of field needs to be 16")

      expect do
        test_instance.format_account_number("1234567890abcde", 16)
      end.to raise_error(ArgumentError, "Invalid account number. Can only be 15 or 16 digits")

      expect do
        test_instance.format_account_number("12345678901234567", 16)
      end.to raise_error(ArgumentError, "Invalid account number. Can only be 15 or 16 digits")

      expect do
        test_instance.format_account_number("12345678901234", 16)
      end.to raise_error(ArgumentError, "Invalid account number. Can only be 15 or 16 digits")

      expect do
        test_instance.format_account_number("993456789012345", 16)
      end.to raise_error(ArgumentError, "Invalid account number. Cannot start with a reserved bank code")
    end
  end
end
