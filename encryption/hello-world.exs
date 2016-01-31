defmodule Bezier do
  def t(a,b,t), do: (1.0 - t) * a + t * b
end

defmodule Recurse do
  def fac(n, res \\ 1) do
    case round(n) do
      1 -> res
      n -> Recurse.fac(n - 1, res * n)
    end
  end
  def fib(n) do
    case round(n) do
      0 -> 0
      1 -> 1
      n -> Recurse.fib(n-1) + Recurse.fib(n-2)
    end
  end
  def fib2(n, start \\ 1, res \\ 0)
  def fib2(n, _start, _res) when n < 0 do :error end
  def fib2(n, start, res) do
    case round(n) do
      1 -> res
      n -> Recurse.fib2(n - 1, res, res + start)
    end
  end
end
