using Statistics

function cost_sqr(x)
  x = abs(x)
  div(x * (x + 1), 2)
end

#=
Dados: a₁, a₂, …, aₙ
  P1 - x = arg min ∑ᵢ |x - aᵢ| mas x ∈ Z

  P2 - x = arg min ∑ᵢ C(|x - aᵢ|) mas x ∈ Z
    C(p) = p (p + 1) / 2 = (p² + p) / 2
    C(|x - aᵢ|) = (α(x - aᵢ)² + (1 - α)|x - aᵢ|) / 2

    α = 1 ⇒ média
    α = 0 ⇒ mediana

  - Se não funcionasse o chute de ceil e floor, a tentativa seria começar na média e buscar o minimizador para os lados
=#
function main()
  line = readline(joinpath(@__DIR__, "demo.txt"))
  # line = readline(joinpath(@__DIR__, "input.txt"))

  positions = parse.(Int, split(line, ","))
  γ = median(positions)
  μ = mean(positions)
  μ⁻, μ⁺ = floor(Int, μ), ceil(Int, μ)
  γ, μ⁻, μ⁺, sum(abs, γ .- positions), sum(cost_sqr, μ⁻ .- positions), sum(cost_sqr, μ⁺ .- positions)
end

main()