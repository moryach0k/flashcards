require 'rails_helper'

RSpec.describe SuperMemo do
  supermemo = SuperMemo.new
  card_info_1 = {
    review_stage: 1,
    interval: 0,
    ef: 2.5,
    quality_timer: 5,
    typos_count: 0
  }
  card_info_2 = {
    review_stage: 3,
    interval: 12,
    ef: 4,
    quality_timer: 5,
    typos_count: 2
  }

  it "returns interval == 1" do
    expect(supermemo.execute(card_info_1)[:interval]).to eq 1
  end

  it "returns review_stage == 2" do
    expect(supermemo.execute(card_info_1)[:review_stage]).to eq 2
  end

  it "returns interval == 0" do
    expect(supermemo.execute(card_info_2)[:interval]).to eq 0
  end
end