defmodule Tryelixir.Cookie do
  @moduledoc """
  Signed cookies.
  """
  @secret :base64.encode(:crypto.strong_rand_bytes(30))

  def encode(cookie) do
    ck = :base64.encode(cookie)
    signature = :base64.encode(:crypto.hash(:sha, [ck, @secret]))
    <<signature :: binary, ck :: binary>>
  end

  def decode(cookie) do
    <<signature :: [size(28), binary], ck :: binary>> = cookie
    if signature == :base64.encode(:crypto.hash(:sha, [ck, @secret])) do
      :base64.decode(ck)
    else
      :error
    end
  end
end
