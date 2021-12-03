using DelimitedFiles, Parsers, Statistics

function bin2num(v)
  n = length(v)
  Int(sum(v[i] * 2^(n-i) for i = 1:n))
end

function median_no_half(v, use_this)
  med = median(v)
  if med == 0.5
    return use_this
  else
    return med
  end
end

function main(M)
  n = size(M, 1)
  γbits = median(M, dims=1)
  ϵbits = 1 .- γbits
  γ = bin2num(γbits)
  ϵ = bin2num(ϵbits)

  I = 1:n
  j = 1
  while length(I) > 1
    I = I[findall(median_no_half(M[I,j], 1) .== M[I,j])]
    j += 1
  end
  oxbits = M[I,:]

  I = 1:n
  j = 1
  while length(I) > 1
    I = I[findall(median_no_half(M[I,j], 1) .!= M[I,j])]
    j += 1
  end
  co2bits = M[I,:]
  ox = bin2num(oxbits)
  co2 = bin2num(co2bits)

  γ * ϵ, ox, co2, ox * co2
end

file = joinpath(@__DIR__, "demo.txt")
file = joinpath(@__DIR__, "input.txt")
M = Parsers.parse.(Int, hcat(split.(readlines(file), "")...))'
main(M)
