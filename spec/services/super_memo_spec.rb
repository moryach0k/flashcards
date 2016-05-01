require 'rails_helper'

RSpec.describe SuperMemo do
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
    expect(SuperMemo.execute(card_info_1)[:interval]).to eq 1
  end

  it "returns review_stage == 2" do
    expect(SuperMemo.execute(card_info_1)[:review_stage]).to eq 2
  end

  it "returns interval == 0" do
    expect(SuperMemo.execute(card_info_2)[:interval]).to eq 0
  end

  it "returns 0 if text mistranslated" do
    expect(SuperMemo.send(:set_quality, card_info_2[:typos_count], card_info_2[:quality_timer])).to eq 0
  end

  it "returns 5 if text translated right and fast" do
    expect(SuperMemo.send(:set_quality, card_info_1[:typos_count], card_info_1[:quality_timer])).to eq 5
  end

  it "returns MIN_EF == 1.3 if ef < 1.3" do
    expect(SuperMemo.send(:set_ef, 1.2, 4)).to eq 1.3
  end

  it "not returns MIN_EF == 1.3 if ef > 1.3" do
    expect(SuperMemo.send(:set_ef, 4, 4)).not_to eq 1.3
  end

  it "returns FIRST_INTERVAL == 1 if review_stage == 1" do
    expect(SuperMemo.send(:set_interval, card_info_1[:review_stage], card_info_1[:interval], card_info_1[:ef])).to eq 1
  end
end