using DelimitedFiles

function main()
  data = readdlm("day-01/input.txt")

  # part 1
  C = count(data[2:end] .> data[1:end-1])
  println("C = $C")

  # part 2
  n = length(data)
  rolling = [sum(data[i:i+2]) for i = 1:n-2]
  C = count(rolling[2:end] .> rolling[1:end-1])
  println("C = $C")
end

main()