defmodule CalculoIMC do
  def calcular_imc(nome, peso_kg, altura_m) do
    imc = peso_kg / (altura_m * altura_m)
    "Olá #{nome}, seu IMC é de #{imc |> Float.round(1) |> Float.to_string}."
  end
end

IO.puts("Digite seu nome:")
nome = IO.gets("") |> String.trim()

IO.puts("Digite seu peso em Kg:")
peso = IO.gets("") |> String.trim() |> String.to_float()

IO.puts("Digite sua altura em metros:")
altura = IO.gets("") |> String.trim() |> String.to_float()

mensagem = CalculoIMC.calcular_imc(nome, peso, altura)
IO.puts(mensagem)