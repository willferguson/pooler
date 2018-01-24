defmodule Waterpark.WaterparkTest do
  use ExUnit.Case

  setup do
    Application.start(Waterpark)
    :ok
  end

  test "Start test worker" do
    Waterpark.Owner.create_pool("test_pool", 5, {Waterpark.TestWorker, :start_link, []})
  end
end
