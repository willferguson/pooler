defmodule Waterpark do
  require Logger

  @moduledoc """
    API facade for Waterpark application.
    All functionality can be executed from this module
  """

  def create_pool(pool_name, worker_limit, worker_mfa) do
    Waterpark.Owner.create_pool(pool_name, worker_limit, worker_mfa)
  end

  def remove_pool(pool_name) do
    Waterpark.Owner.remove_pool(pool_name)
  end

  def run(pool_name, args) do
    Waterpark.Pool.run(pool_name, args)
  end

  def enqueue(pool_name, args) do
    Waterpark.Pool.enqueue(pool_name, args)
  end

  def status(pool_name) do
    Waterpark.Pool.status(pool_name)
  end

  def stop do
    Waterpark.Owner.stop()
    System.stop()
  end

  def pool_count() do
    Waterpark.Owner.pool_count()
  end
end
