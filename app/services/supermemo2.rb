class SuperMemo2

  #q - user response quality [1 .. 5], depends on quality_timer
  #ef - value of E-factor

  MIN_EF = 1.3
  FIRST_INTERVAL = 1
  SECOND_INTERVAL = 6

  def initialize(review_stage, interval, ef, quality_timer, typos_count)
    @review_stage = review_stage
    @interval = interval
    @ef = ef
    @quality_timer = quality_timer
    @typos_count = typos_count
    calculate_q
  end

  def update_after_review
    if q < 3
      reset_interval
    else
      update_ef
      calculate_interval
    end
    {
      interval: @interval,
      ef: @ef,
      rewiew_date: Time.current + @interval.days,
      review_stage: @review_stage + 1
    }
  end

  private

  def calculate_q
    if @typos_count > 1
      @q = 0
    elsif @typos_count == 1
      @q = 3
    else
      @q = case @quality_timer
           when 0..30
             5
           when 31..60
             4
           end
    end
  end

  def update_ef
    if @ef < MIN_EF
      @ef = MIN_EF
    else
      @ef = @ef + (0.1 -(5 - @q) * (0.08 + (5 - @q) * 0.02))
    end
  end

  def reset_interval
    @interval = 0
  end

  def calculate_interval
    @interval = case @review_stage
                when 1
                  FIRST_INTERVAL
                when 2
                  SECOND_INTERVAL
                else
                  (@interval * @ef).round
                end
  end

end