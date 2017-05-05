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
end

