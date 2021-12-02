using Parsers, LinearAlgebra

# dict(Δ, aim) = Dict(
#   "forward" => [Δ, aim * Δ, 0],
#   "up" => [0, 0, -Δ],
#   "down" => [0, 0, Δ],
# )

function runcmd(cmd, Δ, x, y, aim)
  # x, y, aim = dict(Δ, aim)[cmd] + [x; y; aim]
  if cmd == "forward"
    x += Δ
    y += aim * Δ
  elseif cmd == "up"
    aim -= Δ
  elseif cmd == "down"
    aim += Δ
  else
    error("What is $cmd")
  end
  return x, y, aim
end

function main(lines)
  x = aim = 0
  y = 0
  aim = 0

  for line in lines
    cmd, Δ = split(line)
    Δ = Parsers.parse(Int, Δ)
    x, y, aim = runcmd(cmd, Δ, x, y, aim)
  end

  return x * aim, x * y
end

lines = readlines(joinpath(@__DIR__, "input.txt"))
main(lines)