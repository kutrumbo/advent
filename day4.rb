require 'csv'

def read_input
  CSV.read('day4.csv')
end

def parse_line(line)
  line.map { |part| parse_range(part) }
end

def parse_range(range)
  parts = range.split('-')
  [parts[0].to_i, parts[1].to_i]
end

def compare_range(range1, range2)
  (range1[0] <= range2[0]) && (range1[1] >= range2[1])
end

def range_contains(ranges)
  compare_range(ranges[0], ranges[1]) || compare_range(ranges[1], ranges[0])
end

def ranges_overlap(ranges)
  ((ranges[0][0]..ranges[0][1]).to_a & (ranges[1][0]..ranges[1][1]).to_a).any?
end

# result = read_input.map do |line|
#   ranges = parse_line(line)
#   range_contains(ranges) ? 1 : 0
# end

# puts result.sum

result = read_input.map do |line|
  ranges = parse_line(line)
  ranges_overlap(ranges) ? 1 : 0
end

puts result.sum