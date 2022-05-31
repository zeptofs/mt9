# frozen_string_literal: true

module MT9
  class TrailerRecord < BaseRecord
    set_line_ending Fixy::Record::LINE_ENDING_CRLF

    field(:record_type,  2,  "1-2",     :alphanumeric) { MT9::Values::DETAIL_RECORD_TYPE }
    field(:key_field,    2,  "3-4",     :alphanumeric) { MT9::Values::TRAILER_KEY_FIELD }
    field(:hash_total,   11, "5-15",    :alphanumeric) { @hash_total.to_s.chars.last(11).join.rjust(11, "0") }
    field(:filler6,      6,  "16-21",   :alphanumeric) { "" }
    field(:total_amount, 10, "22-31",   :alphanumeric) { @total_amount.to_s.rjust(10, "0") }
    field(:filler129,    129, "32-160", :alphanumeric) { "" }
  end
end
