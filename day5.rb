require 'csv'

def read_input
  CSV.read('day5.csv')
end

# BUCKETS = 3
# STACK_END = 4

BUCKETS = 9
STACK_END = 9

def parse_stack(lines)
  stacks = Array.new(BUCKETS, []).map(&:dup)
  stack_lines = lines.first(STACK_END - 1)
  stack_lines.each do |line|
    chars = line.first.split('').first(BUCKETS * 4)
    chars.each_with_index do |char, index|
      if ((index - 1) % 4) == 0 && char != ' '
        stack_num = ((index + 1) / 4) + 1
        stacks[stack_num - 1] << char
      end
    end
  end
  stacks
end

def parse_moves(lines)
  lines.slice(STACK_END + 1, lines.length).map do |line|
    parts = line.first.split(' ')
    [parts[1], parts[3], parts[5]].map(&:to_i)
  end
end

def execute_move(stack, move)
  puts "executing move: #{move.join(',')}"
  moved_boxes = []
  (1..move.first).each do |_|
    moved_boxes << stack[move[1] - 1].shift
  end
  puts "moving boxes: #{moved_boxes.join('')}"
  moved_boxes.reverse.each do |box|
    stack[move[2] - 1].unshift(box)
  end
  puts '***'
  print_stack(stack)
end

def print_stack(stacks)
  stacks.each_with_index do |stack, index|
    puts [index + 1, stack.join('')].join(',')
  end
  puts '***'
end

lines = read_input
init_stack = parse_stack(lines)
moves = parse_moves(lines)

moves.each { |move| execute_move(init_stack, move) }

puts init_stack.map(&:first).join('')