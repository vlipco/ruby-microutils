require "spec_helper"

RSpec.describe Time do
  
  let(:past_time) { Time.new 1989, 10, 13, 17, 0, 0, "-05:00" }
  let(:past_time_ms) { 624319200000 }
  let(:past_time_plus_second) { Time.at(past_time.to_i + 1) }

  it "can be converted to_ms since epoch" do
    # compare to actual timestamp obtained from JS
    expect(past_time.to_ms).to equal(past_time_ms)
  end
  
   it "takes into account decimals when converting to_ms" do
    # create a decimal on ruby regular timestamp (seconds)
    # to ensure edge case operation
    decim = (past_time_ms/1000) + 0.5
    expect(Time.at(decim).to_ms).to eq(past_time_ms+500)
  end
  
  it "can calculate the duration of a block" do
    duration_ms = Time.measure { sleep 0.1 }
    # this is a very simplified validation, but it does check things!
    expect(duration_ms).to satisfy { |v| v >= 100 && v < 200 }
  end
  
  it "can be created from_ms given a timestamp" do
    recalc = Time::from_ms past_time_ms
    # avoid comparing dates directly, use their epoch version
    expect(recalc.to_f).to equal(past_time.to_f)
  end
  
  it "can calculate ms_since another Time instance" do
    diff = past_time_plus_second.ms_since past_time
    expect(diff).to equal(1000)
  end
  
  it "doesn't affect exceptions raised in a block being timed" do
    class WhateverError < StandardError; end
    expect { 
      Time.measure { raise WhateverError.new("whatever") }
    }.to raise_error(WhateverError)
  end
  
  it "can return elapsed_ms until the present" do
    ref = Time.now
    sleep 1
    later = Time.now
    expect(ref.elapsed_ms).to satisfy { |v| v >= 1000 }
  end

end
