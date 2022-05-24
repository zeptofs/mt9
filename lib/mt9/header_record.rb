# frozen_string_literal: true

module MT9
  class HeaderRecord < BaseRecord
    set_line_ending Fixy::Record::LINE_ENDING_CRLF

    attr_reader :file_type, :account_number, :due_date, :client_short_name

    field :file_type, 2, "1-2", :alphanumeric
    field :account_number, 16, "3-18", :alphanumeric
    field :due_date, 6, "19-24", :alphanumeric
    field :filler7, 7, "25-31", :alphanumeric
    field :client_short_name, 20, "32-51", :alphanumeric
    field :filler109, 109, "52-160", :alphanumeric

    field_value :filler1, SPACE
    field_value :filler7, SPACE * 7
    field_value :filler109, SPACE * 109

    def initialize(...)
      validator = Validators::HeaderRecordContract.new
      result = validator.call(...)
      raise MT9::ValidationError, result unless result.success?

      result.to_h.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
