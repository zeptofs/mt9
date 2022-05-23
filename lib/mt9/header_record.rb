# frozen_string_literal: true

module MT9
  class HeaderRecord < BaseRecord
    set_line_ending Fixy::Record::LINE_ENDING_CRLF

    attr_reader :file_type, :account_number, :due_date, :client_short_name

    field :file_type, 2, "1-2", :file_type
    field :account_number, 16, "3-18", :account_number
    field :due_date, 6, "19-24", :numeric
    field :filler7, 7, "25-31", :alphanumeric
    field :client_short_name, 20, "32-51", :alphanumeric
    field :filler109, 109, "52-160", :alphanumeric

    field_value :filler1, SPACE
    field_value :filler7, SPACE * 7
    field_value :filler109, SPACE * 109

    def initialize(file_type:, account_number:, due_date:, client_short_name: "")
      @file_type = file_type
      @account_number = account_number
      @due_date = due_date
      @client_short_name = client_short_name
    end
  end
end
