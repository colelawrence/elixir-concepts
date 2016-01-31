# This module encrypts a stream with another stream and decrypts
defmodule Encr do
  def readCharStream(filename) do
    stream = File.stream!(filename)
    stream |> Stream.flat_map(&String.to_char_list(&1))# |> Stream.map(&to_char(&1))
  end
  def readChars(filename, chars \\ 16) do
     readCharStream(filename) |> Enum.take(chars)
  end
  def encryptStream(filename, key \\ "./test-key.key") do
    data = readCharStream filename
    key = readCharStream(key) |> Stream.cycle()
    data |> Stream.zip(key) |> Stream.map(&(elem(&1,0) + elem(&1,1)))
  end
  def decryptStream(encryptedCharStream, key \\ "./test-key.key") do
    key = readCharStream(key) |> Stream.cycle()
    encryptedCharStream |> Stream.zip(key) |> Stream.map(&(elem(&1,0) - elem(&1,1)))
  end
end

keyfile = "./test-key.key"
IO.puts Encr.readChars("./hello-world.exs")
IO.puts Encr.readChars(keyfile)
encStream = Encr.encryptStream("./hello-world.exs")
IO.puts encStream |> Enum.take(16)
decrStream = Encr.decryptStream encStream
IO.puts decrStream |> Enum.take(16)
