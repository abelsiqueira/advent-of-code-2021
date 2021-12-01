using DelimitedFiles, Parsers

function main(data::Array{Int})
  # part 1
  n = length(data)
  # C1 = count(data[2:end] .> data[1:end-1])
  # C1 = count(i -> data[i+1] > data[i], 1:n-1)
  # C1 = count(data[i+1] > data[i] for i = 1:n-1)
  C1 = sum(data[i+1] > data[i] for i = 1:n-1)

  # part 2
  # rolling = [sum(data[i:i+2]) for i = 1:n-2]
  # C2 = count(rolling[2:end] .> rolling[1:end-1])
  # C2 = count(data[i+3] > data[i] for i = 1:n-3)
  # C2 = sum(data[i+3] > data[i] for i = 1:n-3)
  C2 = count(i -> data[i+3] > data[i], 1:n-3)

  C1, C2
end

data = Parsers.parse.(Int, readlines("day-01/input.txt"))
main(data)