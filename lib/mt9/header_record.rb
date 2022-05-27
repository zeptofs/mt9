# frozen_string_literal: true

module MT9
  class HeaderRecord < BaseRecord
    set_line_ending Fixy::Record::LINE_ENDING_CRLF

    attr_reader :file_type, :account_number, :client_short_name

    field :file_type, 2, "1-2", :alphanumeric
    field :account_number, 16, "3-18", :alphanumeric
    field :due_date, 8, "19-26", :alphanumeric
    field(:filler5, 5, "27-31", :alphanumeric) { "" }
    field :client_short_name, 20, "32-51", :alphanumeric
    field(:filler109, 109, "52-160", :alphanumeric) { "" }

    def initialize(...)
      validator = Validators::HeaderRecordContract.new
      result = validator.call(...)
      raise MT9::ValidationError, result unless result.success?

      result.to_h.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def due_date
      @due_date.strftime("%C%y%m%d") # CCYYMMDD
    end
  end
end
