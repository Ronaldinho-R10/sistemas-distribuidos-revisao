defmodule SequenciaInversa do
  def ler_e_exibir_inverso(n) do
    numeros = ler_numeros(n)
    inverso = Enum.reverse(numeros)
    IO.puts("Sequência inversa: #{inverso}")
  end

  defp ler_numeros(n) do
    IO.puts("Digite a sequência de #{n} números inteiros (um por linha):")
    Enum.map(1..n, fn _ ->
      IO.gets("") |> String.trim() |> String.to_integer()
    end)
  end
end

IO.puts("Digite a quantidade de números:")
quantidade = IO.gets("") |> String.trim() |> String.to_integer()

SequenciaInversa.ler_e_exibir_inverso(quantidade)
