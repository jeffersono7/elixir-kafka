defmodule BankOne.Transfers.Recipient do
  @topic "bank_one-transfer"
  @hosts [localhost: 9093]
  @partitions 5

  def send_transfers_to_kafka(transfers) do
    :ok = :brod.start_client(@hosts, :bank_one, _client_config = [])
    :ok = :brod.start_producer(:bank_one, @topic, _producer_config = [])

    Enum.with_index(transfers, 1)
    |> Enum.each(fn {transfer, index} ->
      partition = rem(index, @partitions)

      :brod.produce(:bank_one, @topic, partition, "", transfer)
    end)

    :ok
  end
end
