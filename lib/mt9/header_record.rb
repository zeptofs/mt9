# frozen_string_literal: true

module MT9
  class HeaderRecord
    attr_reader :file_type, :account_number, :due_date, :client_short_name

    def initialze(attrs = {})
      validator = Validators::HeaderRecordContract.new

      result = validator.call(attrs)
      raise MT9::ValidationError(result) unless result.success?

      result.to_h.each do |key, value|
        send("#{key}=", value)
      end
    end
  end
end
