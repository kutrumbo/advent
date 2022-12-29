require 'csv'

# MOVES = {
#   a: 'ROCK',
#   b: 'PAPER',
#   c: 'SCISSORS',
#   x: 'ROCK',
#   y: 'PAPER',
#   z: 'SCISSORS',
# }

SCORE = {
  a: 1,
  b: 2,
  c: 3,
  loss: 0,
  draw: 3,
  win: 6,
}

RESULT = {
  a: {
    a: :draw,
    b: :win,
    c: :loss,
  },
  b: {
    a: :loss,
    b: :draw,
    c: :win,
  },
  c: {
    a: :win,
    b: :loss,
    c: :draw,
  },
}

MOVE = {
  a: {
    x: :c,
    y: :a,
    z: :b,
  },
  b: {
    x: :a,
    y: :b,
    z: :c,
  },
  c: {
    x: :b,
    y: :c,
    z: :a,
  },
}

def determine_move(opp_move, instruction)
  MOVE[opp_move][instruction]
end

def match_result(opp_move, my_move)
  RESULT[opp_move][my_move]
end

def match_score(opp_move, instruction)
  my_move = determine_move(opp_move, instruction)
  # puts my_move
  result = match_result(opp_move, my_move)
  SCORE[my_move] + SCORE[result]
end

def score_round(moves)
  moves.map do |move|
    match_score(move[0], move[1])
  end
end

# TEST

# sample_moves = [[:a, :y], [:b, :x], [:c, :z]]
# puts score_round(sample_moves).sum

def parse_moves
  lines = CSV.read('day2.csv')
  lines.map do |line|
    line.first.downcase.split(' ').map(&:to_sym)
  end
end

round_1_moves = parse_moves
round_1_result = score_round(round_1_moves)
total = round_1_result.sum
puts total
