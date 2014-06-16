array = []

1_000_000.times { |i| array << i.to_f * i.to_f }

puts("#{array.length} iterations")
