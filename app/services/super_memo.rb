class SuperMemo
  # q - user response quality [1 .. 5], depends on quality_timer
  # ef - value of E-factor

  MIN_EF = 1.3
  FIRST_INTERVAL = 1
  SECOND_INTERVAL = 6

  def initialize()
  end

  def execute(card_info)
    review_stage = card_info[:review_stage]
    interval = card_info[:interval]
    ef = card_info[:ef]
    quality_timer = card_info[:quality_timer]
    typos_count = card_info[:typos_count]
    q = set_quality(typos_count, quality_timer)
    if q < 3
      interval = 0
    else
      ef = set_ef(ef, q)
      interval = set_interval(review_stage, interval, ef)
    end
    {
      interval: interval,
      ef: ef,
      review_date: Time.current + interval.days,
      review_stage: review_stage + 1
    }
  end

  private

  def set_quality(typos_count, quality_timer)
    if typos_count > 1
      0
    elsif typos_count == 1
      3
    else
      case quality_timer
      when 0..30
        5
      else
        4
      end
    end
  end

  def set_ef(ef,q)
    if ef < MIN_EF
      MIN_EF
    else
       ef + (0.1 -(5 - q) * (0.08 + (5 - q) * 0.02))
    end
  end

  def set_interval(review_stage, interval, ef)
    case review_stage
    when 1
      FIRST_INTERVAL
    when 2
      SECOND_INTERVAL
    else
      (interval * ef).round
    end
  end
end
