# Usando Elixir com Broadway para Kafka

## Como começar

- Clone o repositorio
- Configure o Erlang e Elixir no seu ambiente
- Instale o docker e docker-compose na sua maquina
- Inicia os containers com "docker-compose up -d"
- Executar o script create-topic.sh para criar os topicos
- No bank_one e bank_two, executar os seguintes passos:

```bash
    $ mix ecto.reset
    $ mix phx.server
```

- Abrir o endereco localhost:8080 para monitorar os topicos com o Kowl
- E finalmente fazer um post para:
    - localhost:4000/api/accounts/transfer_to_bank_two?amountPerTransfer=100000
    - localhost:4001/api/accounts/transfer_to_bank_one?amountPerTransfer=100000

*E então as aplicações irão começar a fazer as transferências*

## Sobre

Basicamente as aplicações são dois bancos *BankOne* e *BankTwo*, cada um com seu banco de dados *Postgres* exclusivo.
Estamos usando Elixir com Phoenix, Ecto, Broadway e BroadwayKafka.

Tem um cadastro prévio de contas no arquivo de seed.exs, pode ser alterado caso precise mudar algum parâmetro, ao executar o ecto.reset ele também será executado e irá criar as contas com saldo de 1 milhão.

Essas apis para transferencias, inicializa o processo de migração de saldo de todas as contas para contas de outro banco com o mesmo id de conta, ou seja: conta id 1 (BankOne) -> conta id 1 (BankTwo). O campo de amountPerTransfer vai especificar quanto deve ser o valor de cada transferência, ou seja, se tenho uma conta com mil reais, e solicito a transferência em valores de 100, essa conta ira ter 10 transferências.

As transferências são salvas no banco de dados e publicadas em topico kafka de acordo cada banco.

- bank_one-transfer (BankOne)
- bank_two-transfer (BankTwo)

O outro banco interessado no evento de transferência, vai estar consumindo o tópico e fazendo a adição de saldo nas suas contas de mesmo id.
