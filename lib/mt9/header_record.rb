# frozen_string_literal: true

module MT9
  class HeaderRecord < BaseRecord
    DIRECT_CREDIT = "12"
    DIRECT_DEBIT = "20"
    FILE_TYPES = [DIRECT_CREDIT, DIRECT_DEBIT].freeze

    attr_reader :file_type, :account_number, :due_date, :client_short_name

    field :file_type, 2, "1-2", :file_type
    field :account_number, 15, "3-17", :account_number
    field :filler1, 1, "18", :alphanumeric
    field :due_date, 6, "19-24", :numeric
    field :filler7, 7, "25-31", :alphanumeric
    field :client_short_name, 20, "32-51", :alphanumeric
    field :filler109, 109, "52-160", :alphanumeric

    field_value :filler1, SPACE
    field_value :filler7, SPACE * 7
    field_value :filler109, SPACE * 109

    def initialize(file_type:, account_number:, due_date:, client_short_name:)
      @file_type = file_type
      @account_number = account_number
      @due_date = due_date
      @client_short_name = client_short_name
    end
  end
end
