using Parsers

function main(lines)
  x = aim = 0
  y = 0
  aim = 0
  for line in lines
    cmd, Δ = split(line)
    Δ = Parsers.parse(Int, Δ)
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
  end

  return x * aim, x * y
end

lines = readlines(joinpath(@__DIR__, "input.txt"))
main(lines)