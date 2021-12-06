struct Board
  numbers :: Matrix{Int}
end

function Board(lines::Array{<: AbstractString,1})
  @assert length(lines) == 5
  numbers = zeros(Int, 5, 5)
  for i = 1:5
    tmp = parse.(Int, split(lines[i]))
    numbers[i,:] .= tmp
  end
  Board(numbers)
end

function solved_when(board::Board, draw)
  M = copy(board.numbers)
  for (i, d) in enumerate(draw)
    idx = findfirst(M .== d)
    if idx === nothing
      continue
    end
    M[idx] = -M[idx] - 1
    if any(all(M[i,:] .< 0) for i = 1:5) || any(all(M[:,i] .< 0) for i = 1:5)
      return M, i
    end
  end
  return M, Inf
end

function main()
  # lines = readlines(joinpath(@__DIR__, "demo.txt"))
  lines = readlines(joinpath(@__DIR__, "input.txt"))
  n = length(lines)
  draw = parse.(Int, split(lines[1], ","))
  boards = [
    Board(lines[i:i+4]) for i = 3:6:n
  ]
  solution_time = [solved_when(b, draw)[2] for b in boards]
  pos, b = findmin(solution_time)
  M = solved_when(boards[b], draw)[1]


  sum(M[findall(M .≥ 0)]) * draw[pos]
end

main()