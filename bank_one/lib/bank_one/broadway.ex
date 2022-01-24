defmodule BankOne.Broadway do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9093],
             group_id: "bank_one",
             topics: ["bank_one-transfer"]
           ]},
        concurrency: 50
      ],
      processors: [
        default: [
          concurrency: 200
        ]
      ],
      batchers: [
        default: [
          batch_size: 3000,
          batch_timeout: 1000,
          concurrency: 200
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    message
    |> Message.update_data(fn data ->
      {:ok, transfer} = Jason.decode(data)

      {data, BankOne.receive_transfer(transfer)}
    end)
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    list = messages |> Enum.map(fn e -> e.data end)

    IO.inspect(list, label: "Got batch")

    messages
  end
end
