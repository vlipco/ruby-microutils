class Time

  class << self
    
    def measure(&block)
      start = Time.now
      yield
      start.elapsed_ms
    end
    
    def from_ms(stamp)
      self.at (stamp.to_f/1000)
    end
    
  end
    
  def elapsed_ms
    Time.now.ms_since self
  end
  
  def ms_since(ref)
    # expects a time object or a int timestamp with milliseconds
    self.to_ms - (ref.class == Time ? ref.to_ms : ref.to_i)
  end
  
  def to_ms
    (self.to_f * 1000).round
  end

end

