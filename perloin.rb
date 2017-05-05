require 'serialport' # NOTE: you probably need to install this gem with: 'gem install serialport'
require_relative 'arduino-lights'

require 'perlin_noise'



def noise_value_to_brightness(noise_value)
  range = 128 # 253
  (noise_value * range).to_i
end

def xy_to_pixel_number(x,y)
  row_offset = y * 12
  if(y % 2 == 0)
    column_offset = (11 - x)
  else
    column_offset = x
  end

  row_offset + column_offset
  # (y * 12) + x
end


n2d = Perlin::Noise.new 3
contrast = Perlin::Curve.contrast(Perlin::Curve::CUBIC, 7)


(0..11).each do |z|
  (0..11).each do |x|
    #puts "next line"
    (0..11).each do |y|
      value = contrast.call(n2d[x / 12.0, y/12.0, z/12.0])
      brightness = noise_value_to_brightness(value)


      pixel_number = xy_to_pixel_number(x,y)
      #puts "x #{x}, y: #{y}, pixel_number: #{pixel_number}"
      #puts "value #{value}, brightness: #{brightness}"
      ArduinoLights::set_pixel(pixel_number, brightness, 0, 0)
    end
  end
  
  ArduinoLights::draw_screen
end


