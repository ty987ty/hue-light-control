class LightControlController < ApplicationController

  require 'hue'
  require 'parallel'

  @lighthue

  def index

  end

  def on
    hue = Hue::Client.new
    hue.lights.each do |light|
      light.on = true
    end
  end

  def of
    hue = Hue::Client.new
    hue.lights.each do |light|
      light.on = false
    end
  end

  def blink
  	#hue = Hue::Client.new
    #light = hue.lights[0]
    hue = Hue::Client.new
    group = hue.groups.first

    10.times do
      group.on = true
      sleep 1.0
      group.on = false
      sleep 1.0
    end
  end

  def random
    hue = Hue::Client.new
    hue.lights.each do |light|
      light.on = true
    end
 
    10.times do
      hue.lights.each do |light|
        puts light.name
        light.hue = rand 65535
        light.saturation = rand 255
        light.brightness = rand 255
      end
      sleep 0.1
    end
  end

  def gradation
  	hue = Hue::Client.new

    Parallel.each(hue.lights, in_threads: 3) {|light|
      light.hue = rand 65535
      @lighthue = light.hue

      100.times do
        light.hue = gardationcalc(@lighthue)
        sleep 0.1
      end
    }
  end

  def gardationcalc(value)
    sum = value + 500
    if sum <= 65535 then
    	@lighthue = sum
    	return sum
    else
    	@lighthue = sum - 65535
        return sum - 65535
    end
  end


end
