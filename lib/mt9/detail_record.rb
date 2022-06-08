# frozen_string_literal: true

module MT9
  class DetailRecord < BaseRecord
    field(:record_type,                 2,  "1-2",     :alphanumeric)
    field(:account_number,              16, "3-18",    :alphanumeric)
    field(:transaction_code,            3,  "19-21",   :alphanumeric)
    field(:amount,                      10, "22-31",   :alphanumeric)
    field(:this_party_name,             20, "32-51",   :alphanumeric)
    field(:this_party_reference,        12, "52-63",   :alphanumeric)
    field(:this_party_code,             12, "64-75",   :alphanumeric)
    field(:this_party_alpha_reference,  12, "76-87",   :alphanumeric)
    field(:this_party_particulars,      12, "88-99",   :alphanumeric)
    field(:filler,                      1,  "100-100", :alphanumeric) { "" }
    field(:other_party_name,            20, "101-120", :alphanumeric)
    field(:other_party_code,            12, "121-132", :alphanumeric)
    field(:other_party_alpha_reference, 12, "133-144", :alphanumeric)
    field(:other_party_particulars,     12, "145-156", :alphanumeric)
    field(:end_filler,                  4,  "157-160", :alphanumeric) { "" }
    # TODO[T2][NZ] Expand / add more appropriate formats once other PR is merged.

    set_line_ending Fixy::Record::LINE_ENDING_CRLF

    def record_type
      MT9::Values::DETAIL_RECORD_TYPE
    end

    def account_number
      @account_number.to_s
    end

    def transaction_code
      @transaction_code.to_s.rjust(3, "0")
    end

    def amount
      @amount.to_s.rjust(10, "0")
    end

    def this_party_name
      @this_party[:name].to_s
    end

    def this_party_reference
      "000000000000" # From ASB Docs: "this field should be all zeros"
    end

    def this_party_code
      @this_party[:code].to_s
    end

    def this_party_alpha_reference
      @this_party[:alpha_reference].to_s
    end

    def this_party_particulars
      @this_party[:particulars].to_s
    end

    def other_party_name
      @other_party[:name].to_s
    end

    def other_party_code
      @other_party[:code].to_s
    end

    def other_party_alpha_reference
      @other_party[:alpha_reference].to_s
    end

    def other_party_particulars
      @other_party[:particulars].to_s
    end
  end
end
