# frozen_string_literal: true

module MT9
  class BaseRecord < Fixy::Record
    include Fixy::Formatter::Alphanumeric

    set_record_length 160
  end
end
