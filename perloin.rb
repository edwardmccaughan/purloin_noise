require 'serialport' # NOTE: you probably need to install this gem with: 'gem install serialport'
require 'perlin_noise'

require_relative 'arduino-lights'
require_relative 'utils'


def mixed_colors_pixel_arrays
  n2d_red = Perlin::Noise.new 3
  n2d_green = Perlin::Noise.new 3
  n2d_blue = Perlin::Noise.new 3

  puts "started generating"

  (0..$z_layers).map do |z|
    (0..11).map do |x|
      (0..11).map do |y|
        value = $contrast.call(n2d_red[x / 12.0, y/12.0, z/12.0])
        red = noise_value_to_brightness(value)

        value = $contrast.call(n2d_green[x / 12.0, y/12.0, z/12.0])
        green = noise_value_to_brightness(value)

        value = $contrast.call(n2d_blue[x / 12.0, y/12.0, z/12.0])
        blue = noise_value_to_brightness(value)

        [red, green, blue]
      end
    end
  end
  puts "finished generating"
end

def single_color_data
  n2d = Perlin::Noise.new 3

  puts "started generating"

  data = (0..$z_layers).map do |z|
    (0..11).map do |x|
      (0..11).map do |y|
        noise_value = $contrast.call(n2d[x / 12.0, y/12.0, z/12.0])

        red = noise_value_to_brightness(noise_value)
        green = 0 #noise_value_to_brightness(value)
        blue = 0 #noise_value_to_brightness(value)

        [red, green, blue]
      end
    end
  end
  puts "finished generating"
  data
end

$contrast = Perlin::Curve.contrast(Perlin::Curve::CUBIC, 7)
$z_layers = 100
pixel_data = single_color_data()

while(true) do
  (0..$z_layers).each do |z|
    (0..11).each do |x|
      (0..11).each do |y|
        pixel_number = xy_to_pixel_number(x,y)

        red, green, blue = pixel_data[z][x][y]


        #puts "x #{x}, y: #{y}, pixel_number: #{pixel_number}"
        #puts "value #{value}, brightness: #{brightness}"
        ArduinoLights::set_pixel(pixel_number, red, green, blue)
      end
    end
    ArduinoLights::draw_screen
  end
end


# (0..11).each do |z|
#   (0..11).each do |x|
#     #puts "next line"
#     (0..11).each do |y|
#       t = Time.now
#       value = contrast.call(n2d_red[x / 12.0, y/12.0, z/12.0])
#       red = noise_value_to_brightness(value)

#       value = contrast.call(n2d_green[x / 12.0, y/12.0, z/12.0])
#       green = noise_value_to_brightness(value)

#       value = contrast.call(n2d_blue[x / 12.0, y/12.0, z/12.0])
#       blue = noise_value_to_brightness(value)

#       pixel_number = xy_to_pixel_number(x,y)

#       puts "calulation took: #{t - Time.now}"







#       #puts "x #{x}, y: #{y}, pixel_number: #{pixel_number}"
#       #puts "value #{value}, brightness: #{brightness}"
#       ArduinoLights::set_pixel(pixel_number, red, green, blue)
#     end
#   end
  
#   ArduinoLights::draw_screen
# end


