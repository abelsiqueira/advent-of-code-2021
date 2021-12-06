signpositive(x) = x == 0 ? 1 : sign(x)

function mark_danger(n, lines; use_diagonal = false)
  M = zeros(Int, n, n)
  for line in lines
    x1, y1, x2, y2 = parse.(Int, split(replace(line, " -> " => ","), ",")) .+ 1
    if (x1 == x2) || (y1 == y2)
      sx, sy = signpositive(x2 - x1), signpositive(y2 - y1)
      M[x1:sx:x2, y1:sy:y2] .+= 1
    end
    if use_diagonal && x1 != x2 && y1 != y2
      sx, sy = signpositive(x2 - x1), signpositive(y2 - y1)
      for idx in zip(x1:sx:x2, y1:sy:y2)
        M[idx...] += 1
      end
    end
  end
  return M
end

function main()
  # lines = readlines(joinpath(@__DIR__, "demo.txt")); n = 10
  lines = readlines(joinpath(@__DIR__, "input.txt")); n = 1000

  M = mark_danger(n, lines)
  α = count(M .≥ 2)

  M = mark_danger(n, lines, use_diagonal=true)
  α, count(M .≥ 2)
end

main()