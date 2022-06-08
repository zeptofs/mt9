# frozen_string_literal: true

module MT9
  class BaseRecord < Fixy::Record
    include Fixy::Formatter::Alphanumeric

    set_record_length 160

    def initialize(...)
      raise NotImplementedError, "Only allowed from subclass" if self.class == BaseRecord

      begin
        validator_class = Object.const_get "MT9::Validators::#{self.class.name.split('::').last}Contract"
      rescue NameError
        raise NotImplementedError, "#{self.class} does not have a corresponding contract"
      end

      result = validator_class.new.call(...)
      raise MT9::ValidationError, result unless result.success?

      result.to_h.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
