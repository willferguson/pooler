defmodule Waterpark.WaterparkTest do
  use ExUnit.Case

  setup_all do
    Application.start(Waterpark)
    :ok
  end

  test "create and destroy pools functions correctly" do
    assert 0 == Waterpark.pool_count()
    Waterpark.create_pool("test_pool", 3, {Waterpark.TestWorker, :start_link, []})
    assert 1 == Waterpark.pool_count()
    Waterpark.create_pool("test_pool2", 3, {Waterpark.TestWorker, :start_link, []})
    assert 2 == Waterpark.pool_count()
    Waterpark.remove_pool("test_pool")
    assert 1 == Waterpark.pool_count()
    Waterpark.remove_pool("test_pool2")
    assert 0 == Waterpark.pool_count()
  end

  test "Start test worker with run" do
    Waterpark.create_pool("test_pool", 3, {Waterpark.TestWorker, :start_link, []})
    {:ok, pid1} = Waterpark.run("test_pool", [[]])
    {:ok, pid2} = Waterpark.run("test_pool", ["2", "3"])
    {:ok, pid3} = Waterpark.run("test_pool", ["3"])
    {:error, _reason} = Waterpark.run("test_pool", ["too_much"])
    Waterpark.remove_pool("test_pool")
  end

  test "Start test workers with enqueue" do
    Waterpark.create_pool("test_pool2", 2, {Waterpark.TestWorker, :start_link, []})
    [free_workers: free, busy_workers: busy, queue_size: queued] = Waterpark.status("test_pool2")
    assert free == 2
    assert busy == 0
    assert queued == 0
    :ok = Waterpark.enqueue("test_pool2", ["a"])
    :ok = Waterpark.enqueue("test_pool2", ["b"])
    :ok = Waterpark.enqueue("test_pool2", ["c"])
    [free_workers: free, busy_workers: busy, queue_size: queued] = Waterpark.status("test_pool2")
    assert free == 0
    assert busy == 2
    assert queued == 1
    Waterpark.remove_pool("test_pool2")
  end
end
