struct Digit
  segments :: Vector
end

function Digit(str)
  Digit(sort(split(str, "")))
end

import Base.-, Base.+, Base.==

Base.length(d::Digit) = length(d.segments)

-(d1::Digit, d2::Digit) = setdiff(d1.segments, d2.segments)

comp(d1::Digit, d2::Digit) = (d1 - d2) ∪ (d2 - d1)

function +(d::Digit, x)
  @assert !(x ∈ d.segments)
  Digit(sort([copy(d.segments); x]))
end

==(d1::Digit, d2::Digit) = ==(d1.segments, d2.segments)

function main()
  lines = readlines(joinpath(@__DIR__, "demo.txt"))
  lines = readlines(joinpath(@__DIR__, "input.txt"))

  # Part 1
  count_easy = 0
  for line in lines
    output = length.(split(split(line, " | ")[2]))
    count_easy += count(x -> x ∈ [2, 3, 4, 7], output)
  end

  # Part 2
  count_hard = 0
  for line in lines
    info, output = split.(split(line, " | "))
    info = [Digit(x) for x in info]

    sizes = length.(info)
    known = Dict(
      1 => info[findfirst(sizes .== 2)],
      4 => info[findfirst(sizes .== 4)],
      7 => info[findfirst(sizes .== 3)],
      8 => info[findfirst(sizes .== 7)],
    )

    # a = only(known[7] - known[1])
    candidates_235 = info[findall(sizes .== 5)]
    if length(comp(candidates_235[1], candidates_235[2])) == 4
      known[3] = candidates_235[3]
    elseif length(comp(candidates_235[1], candidates_235[3])) == 4
      known[3] = candidates_235[2]
    elseif length(comp(candidates_235[2], candidates_235[3])) == 4
      known[3] = candidates_235[1]
    else
      error("Unexpected")
    end
    b = only(comp(known[4], known[3]) ∩ comp(known[4], known[1]))
    known[9] = known[3] + b

    candidates_069 = info[findall(sizes .== 6)]
    known[5], known[6] = only([
      (d1, d2) for d1 ∈ candidates_235,
                   d2 ∈ candidates_069
                   if d1 != known[3] && d2 != known[9] && length(comp(d1, d2)) == 1
    ])

    known[2] = only(d for d ∈ candidates_235 if d != known[3] && d != known[5])
    known[0] = only(d for d ∈ candidates_069 if d != known[6] && d != known[9])

    # for (k, v) in known
    #   println("$k => $v")
    # end

    output = [Digit(x) for x in output]
    output_number = parse(Int, join([
      only([k for (k, v) in known if v == o]) for o in output
    ]))
    count_hard += output_number
  end

  count_easy, count_hard
end

main()