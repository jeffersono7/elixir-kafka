defmodule BankTwo.Transfers.Recipient do
  @topic "bank_two-transfer"
  @hosts [localhost: 9093]
  @partitions 50

  def send_transfers_to_kafka(transfers) do
    :ok = :brod.start_client(@hosts, :bank_two, _client_config = [])
    :ok = :brod.start_producer(:bank_two, @topic, _producer_config = [])

    Enum.with_index(transfers, 1)
    |> Enum.each(fn {transfer, index} ->
      partition = rem(index, @partitions)
      {:ok, json} = Jason.encode(transfer)

      :brod.produce(:bank_two, @topic, partition, "", json)
    end)

    :ok
  end
end
