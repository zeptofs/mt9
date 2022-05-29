# frozen_string_literal: true

RSpec.describe MT9::Validators::TrailerRecordContract do
  subject(:result) { described_class.new.call(trailer_record) }

  let(:trailer_record) do
    {
      hash_total: hash_total,
      total_amount: total_amount,
    }
  end

  let(:hash_total) { 12_345_678_901 }
  let(:total_amount) { 987_654_321_123 }

  it "validates a correct header record" do
    expect(result).to be_success
  end

  # context "with a short hash total" do
  #   let(:hash_total) { 345_678_901 }

  #   it "shows an error" do
  #     expect(result.errors[:hash_total]).to eq(["must have atleast 11 digits"])
  #   end
  # end

  context "with a long total amount" do
    let(:total_amount) { 123_987_654_321_123 }

    it "shows an error" do
      expect(result.errors[:total_amount]).to eq(["must not have more than 12 digits"])
    end
  end
end
