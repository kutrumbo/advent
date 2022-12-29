require 'csv'

lines = CSV.read('./day1.csv')

chunks = []
accumulator = []

lines.each do |line|
  if line.length == 1
    accumulator << line.first.to_i
  else
    chunks << [accumulator.sum, accumulator]
    accumulator = []
  end
end

# if any lines not assigned to chunk after reading all, push em'
unless accumulator.length == 0
  chunks << [accumulator.sum, accumulator]
end

# get max
max_amt = chunks.sort_by(&:first).last.first

puts max_amt

top_three_sum = chunks.sort_by(&:first).last(3).map(&:first).sum

puts top_three_sum