# Resolução

## 1. Exiba “Olá mundo!”;

```elixir
IO.puts "Olá, mundo!"
``


## 2. Leia um nome e exiba: “Olá <nome>!”;
IO.puts "Digite seu nome:"
nome = IO.gets("")
```elixir
IO.puts "Olá, #{String.trim(nome)}!"
```

## 3. Leia um nome e ano de nascimento e exiba: “Olá <nome>, você tem <idade> anos.”;
```elixir
defmodule Saudacao do
  def run do
    IO.puts "Digite seu nome:"
    nome = IO.gets("")

    IO.puts "Digite seu ano de nascimento:"
    ano_nascimento = IO.gets("")

    idade = Date.utc_today().year() - String.trim(ano_nascimento) |> Integer.parse() |> elem(0)

    IO.puts "Olá, #{String.trim(nome)}, você tem #{idade} anos."
  end
end

Saudacao.run()
```

## 4.Leia nome, peso em Kg e altura e centímetros e exiba “Olá <nome>, seu IMC é de <idade>.”;: 

```elixir
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
```


## 5. Leia uma sequência de n números inteiros e exiba-os na ordem inversa à da leitura;

```elixir
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
```

## 6. Leia n pares matrícula/nome e guarde-os em um dicionário;

```elixir
defmodule ArmazenarMatriculasNomes do
  def ler_e_armazenar(n) do
    matriculas_nomes = ler_matriculas_nomes(n)
    dicionario = Enum.into(matriculas_nomes, %{})
    IO.inspect(dicionario)
  end

  defp ler_matriculas_nomes(n) do
    IO.puts("Digite os pares matrícula/nome (um por linha):")
    Enum.map(1..n, fn _ ->
      {matricula, nome} = ler_matricula_nome()
      {matricula, nome}
    end)
  end

  defp ler_matricula_nome do
    IO.puts("Matrícula:")
    matricula = IO.gets("") |> String.trim()

    IO.puts("Nome:")
    nome = IO.gets("") |> String.trim()

    {matricula, nome}
  end
end

IO.puts("Digite a quantidade de pares matrícula/nome:")
quantidade = IO.gets("") |> String.trim() |> String.to_integer()

ArmazenarMatriculasNomes.ler_e_armazenar(quantidade)

```

## 7/8.Implemente um menu básico de um sistema CRUD para cadastrar pontos 2D de um polígono. Implemente 5 funções:
principal/0
criar/0
listar/0
atualizar/0
excluir/0
sair/0

Sistema Final
=============

1. Criar
2. Listar
3. Atualizar
4. Excluir
5. Sair

Entre com sua opção: 


## Estenda seu sistema CRUD implementando as funcionalidades de translação, escala (“Zoom”), rotação e reflexão. Veja a apresentação anexa a este exercício no GSA.

```elixir
defmodule SistemaCRUD do
  defstruct x: 0, y: 0

  @pontos %{}

  def principal do
    menu()
  end

  def menu do
    IO.puts("Sistema Final")
    IO.puts("=============")
    IO.puts("1. Criar ponto")
    IO.puts("2. Listar pontos")
    IO.puts("3. Atualizar ponto")
    IO.puts("4. Excluir ponto")
    IO.puts("5. Translação")
    IO.puts("6. Escala")
    IO.puts("7. Rotação")
    IO.puts("8. Reflexão")
    IO.puts("9. Sair")
    IO.puts("Entre com sua opção:")

    opcao = IO.gets(" |> ")
    opcao = String.trim(opcao) |> String.to_integer()

    case opcao do
      1 -> criar_ponto()
      2 -> listar_pontos()
      3 -> atualizar_ponto()
      4 -> excluir_ponto()
      5 -> translacao()
      6 -> escala()
      7 -> rotacao()
      8 -> reflexao()
      9 -> sair()
      _ -> menu()
    end
  end

  def criar_ponto do
    IO.puts("Função Criar Ponto")
    IO.puts("Digite o número do ponto:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    IO.puts("Digite a coordenada x:")
    x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    IO.puts("Digite a coordenada y:")
    y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = %SistemaCRUD{x: x, y: y}
    @pontos = Map.put(@pontos, numero, ponto)

    IO.puts("Ponto criado com sucesso!")
    menu()
  end

  def listar_pontos do
    IO.puts("Função Listar Pontos")

    pontos = @pontos

    Enum.each(Map.keys(pontos), fn numero ->
      ponto = Map.get(pontos, numero)
      IO.puts("Ponto #{numero}: x = #{ponto.x}, y = #{ponto.y}")
    end)

    menu()
  end

  def atualizar_ponto do
    IO.puts("Função Atualizar Ponto")
    IO.puts("Digite o número do ponto a ser atualizado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(@pontos, numero)

    if ponto do
      IO.puts("Digite a nova coordenada x:")
      x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite a nova coordenada y:")
      y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      ponto = %SistemaCRUD{x: x, y: y}
      @pontos = Map.put(@pontos, numero, ponto)

      IO.puts("Ponto atualizado com sucesso!")
    else
      IO.puts("Ponto não encontrado.")
    end

    menu()
  end

  def excluir_ponto do
    IO.puts("Função Excluir Ponto")
    IO.puts("Digite o número do ponto a ser excluído:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(@pontos, numero)

    if ponto do
      @pontos = Map.delete(@pontos, numero)
      IO.puts("Ponto excluído com sucesso!")
    else
      IO.puts("Ponto não encontrado.")
    end

    menu()
  end

  def translacao do
    IO.puts("Função Translação")
    IO.puts("Digite o número do ponto a ser transladado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(@pontos, numero)

    if ponto do
      IO.puts("Digite o fator de translação em x:")
      tx = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite o fator de translação em y:")
      ty = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      ponto = %SistemaCRUD{x: ponto.x + tx, y: ponto.y + ty}
      @pontos = Map.put(@pontos, numero, ponto)

      IO.puts("Translação realizada com sucesso!")
    else
      IO.puts("Ponto não encontrado.")
    end

    menu()
  end

  def escala do
    IO.puts("Função Escala")
    IO.puts("Digite o número do ponto a ser escalado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(@pontos, numero)

    if ponto do
      IO.puts("Digite o fator de escala em x:")
      sx = IO.gets(" |> ") |> String.trim() |> String.to_float()

      IO.puts("Digite o fator de escala em y:")
      sy = IO.gets(" |> ") |> String.trim() |> String.to_float()

      ponto = %SistemaCRUD{x: ponto.x * sx, y: ponto.y * sy}
      @pontos = Map.put(@pontos, numero, ponto)

      IO.puts("Escala realizada com sucesso!")
    else
      IO.puts("Ponto não encontrado.")
    end

    menu()
  end

  def rotacao do
    IO.puts("Função Rotação")
    IO.puts("Digite o número do ponto a ser rotacionado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(@pontos, numero)

    if ponto do
      IO.puts("Digite o ângulo de rotação em graus:")
      angulo = IO.gets(" |> ") |> String.trim() |> String.to_float()

      radianos = angulo * Math.PI / 180.0
      {new_x, new_y} = {
        ponto.x * Math.cos(radianos) - ponto.y * Math.sin(radianos),
        ponto.x * Math.sin(radianos) + ponto.y * Math.cos(radianos)
      }

      ponto = %SistemaCRUD{x: new_x, y: new_y}
      @pontos = Map.put(@pontos, numero, ponto)

      IO.puts("Rotação realizada com sucesso!")
    else
      IO.puts("Ponto não encontrado.")
    end

    menu()
  end

  def reflexao do
    IO.puts("Função Reflexão")
    IO.puts("Digite o número do ponto a ser refletido:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(@pontos, numero)

    if ponto do
      IO.puts("Escolha o eixo de reflexão:")
      IO.puts("1. Reflexão em relação ao eixo x")
      IO.puts("2. Reflexão em relação ao eixo y")

      opcao = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      case opcao do
        1 -> ponto = %SistemaCRUD{x: ponto.x, y: -ponto.y}
        2 -> ponto = %SistemaCRUD{x: -ponto.x, y: ponto.y}
        _ -> IO.puts("Opção inválida.")
      end

      @pontos = Map.put(@pontos, numero, ponto)

      IO.puts("Reflexão realizada com sucesso!")
    else
      IO.puts("Ponto não encontrado.")
    end

    menu()
  end

  def sair do
    IO.puts("Saindo do sistema. Adeus!")
  end
end

# Inicie o sistema chamando a função principal
SistemaCRUD.principal()
```


