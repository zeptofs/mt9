# frozen_string_literal: true

require_relative "fixy/formatter"

module MT9
  class BaseRecord < Fixy::Record
    include Fixy::Formatter::Alphanumeric
    include Fixy::Formatter::Numeric

    SPACE = " "

    set_record_length 160
  end
end
