function main()
  # lines = readlines(joinpath(@__DIR__, "demo.txt"))
  lines = readlines(joinpath(@__DIR__, "input.txt"))

  initial_fishes = parse.(Int, split(lines[1], ","))
  fish_per_day = zeros(Int, 9)
  for i in initial_fishes
    fish_per_day[i + 1] += 1
  end
  for d = 1:256
    new_fpd = [fish_per_day[2:end]; fish_per_day[1]]
    new_fpd[7] += fish_per_day[1]
    fish_per_day .= new_fpd
    # println("d = $d, fdp = $new_fpd, total = $(sum(new_fpd))")
    if d in [18, 80, 256]
      println("d = $d, total = $(sum(new_fpd))")
    end
  end

  sum(fish_per_day)
end

main()