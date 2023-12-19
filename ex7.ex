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