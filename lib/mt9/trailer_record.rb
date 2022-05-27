# frozen_string_literal: true

module MT9
  class TrailerRecord < BaseRecord
    set_line_ending Fixy::Record::LINE_ENDING_CRLF

    attr_reader :hash_total, :total_amount

    field(:record_type,  2,  "1-2",     :alphanumeric) { MT9::DETAIL_RECORD_TYPE }
    field(:key_field,    2,  "3-4",     :alphanumeric) { MT9::TRAILER_KEY_FIELD }
    field :hash_total,   11, "5-15",    :alphanumeric
    field(:filler6,      6,  "16-21",   :alphanumeric) { "" }
    field :total_amount, 10, "22-31",   :alphanumeric
    field(:filler129,    129, "32-160", :alphanumeric) { "" }
  end
end
