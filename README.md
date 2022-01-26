# Usando Elixir com Broadway para Kafka

### Como começar

- Clone o repositorio
- Configure o Erlang e Elixir no seu ambiente
- Instale o docker e docker-compose na sua maquina
- Inicia os containers com "docker-compose up -d"
- Executar o script create-topic.sh para criar os topicos
- No bank_one e bank_two, executar os seguintes passos:
    - mix ecto.reset
    - mix phx.server
- Abrir o endereco localhost:8080 para monitorar os topicos com o Kowl
- E finalmente fazer um post para:
    - localhost:4000/api/accounts/transfer_to_bank_one?amountPerTransfer=100000
    - localhost:4001/api/accounts/transfer_to_bank_two?amountPerTransfer=100000

*E então as aplicações irão começar a fazer as transferências*