defmodule BankOne.Transfers.Recipient do
  @topic "bank_one-transfer"
  @hosts [localhost: 9093]
  @partitions 50

  # TODO por numa arvore de supervisao o brod
  # auto_start_producers: true inside client_config no start_client
  def send_transfers_to_kafka(transfers) do
    :ok = :brod.start_client(@hosts, :bank_one, _client_config = [])
    :ok = :brod.start_producer(:bank_one, @topic, _producer_config = [])

    Enum.with_index(transfers, 1)
    |> Enum.each(fn {transfer, index} ->
      partition = rem(index, @partitions)
      {:ok, json} = Jason.encode(transfer)

      :brod.produce(:bank_one, @topic, partition, "", json)
    end)

    :ok
  end

  defp random_partitioner(_topic, partitions_count, _key, _value) do
    partition = Enum.random(0..(partitions_count - 1))

    {:ok, partition}
  end
end
