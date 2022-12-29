require 'csv'

PRIORITIES = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')

def parse_contents(contents)
  each_size = contents.length / 2
  [contents[0..each_size - 1].split(''), contents[each_size..-1].split('')]
end

def read_input
  lines = CSV.read('day3.csv')
end

def parse_mistake(contents)
  contents.first.find { |c| contents.last.index(c) }
end

def priority(char)
  PRIORITIES.index(char) + 1
end

def sum_priorities(input)
  contents = input.map { |line| parse_contents(line.first) }
  contents.map do |content|
    priority(parse_mistake(content))
  end.sum
end

# puts sum_priorities(read_input)

def content_groups(input)
  groups = []
  group = []
  input.each_with_index do |line, index|
    group << line.first.split('')
    if ((index + 1) % 3) == 0
      groups << group.dup
      group = []
    end
  end
  groups
end

def find_badge(group)
  group.first.find do |char|
    group[1].index(char) && group[2].index(char)
  end
end

def score_groups(groups)
  groups.map { |group| priority(find_badge(group)) }.sum
end

puts score_groups(content_groups(read_input))