# frozen_string_literal: true

RSpec.describe MT9::BaseRecord do
  it "can't be initialised" do
    expect { described_class.new }.to raise_error(NotImplementedError, "Only allowed from subclass")
  end
end
