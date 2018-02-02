defmodule Waterpark.WaterparkTest do
  use ExUnit.Case

  setup do
    Application.start(Waterpark)
    :ok
  end

  test "Start test worker with run" do
    Waterpark.create_pool("test_pool", 3, {Waterpark.TestWorker, :start_link, []})
    {:ok, pid1} = Waterpark.run("test_pool", [[]])
    {:ok, pid2} = Waterpark.run("test_pool", ["2"])
    {:ok, pid3} = Waterpark.run("test_pool", ["3"])
    {:error, _reason} = Waterpark.run("test_pool", ["too_much"])
  end

  #TODO Test Workers never finish so the last never gets enqueued.
  #TODO Need make this into a proper test and have api to determine number of queued and running workers
  test "Start test workers with enqueue" do
    Waterpark.create_pool("test_pool2", 3, {Waterpark.TestWorker, :start_link, []})
    :ok = Waterpark.enqueue("test_pool2", ["a"])
    :ok = Waterpark.enqueue("test_pool2", ["b"])
    :ok = Waterpark.enqueue("test_pool2", ["c"])
    :ok = Waterpark.enqueue("test_pool2", ["d"])
  end
end
