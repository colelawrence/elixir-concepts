Phoenix

http://www.phoenixframework.org/docs/up-and-running

Setting up pgsql

Reading http://www.postgresql.org/docs/9.3/static/creating-cluster.html

$ initdb -D ./pgsql-data

http://www.phoenixframework.org/docs/mix-tasks#section--ecto-create-
http://www.postgresql.org/docs/9.2/static/tutorial-accessdb.html


```
D:\Users\Cole\Desktop\hello_phoenix>mix ecto.create
** (Mix) The database for HelloPhoenix.Repo couldn't be created, reason given: ERROR:  22023: new en
coding (UTF8) is incompatible with the encoding of the template database (WIN1252)
HINT:  Use the same encoding as in the template database, or use template0 as template.
LOCATION:  createdb, src\backend\commands\dbcommands.c:359
.

D:\Users\Cole\Desktop\hello_phoenix>createdb postgres
```
https://www.odoo.com/es_ES/forum/help-1/question/dataerror-new-encoding-utf8-is-incompatible-with-the-encoding-of-the-template-database-sql-ascii-52124

Started Postgresql:
$ "postgres" -D "./pgsql-data"
Started server using:
$ mix phoenix.server

# Elixir

```elixir
iex> x = 42
42
iex> (fn -> x = 0 end).()
0
iex> x
42
```

Resume: http://elixir-lang.org/getting-started/basic-types.html#tuples

> Tuples store elements contiguously in memory

> Notice that put_elem/3 returned a new tuple.
> The original tuple stored in the tuple variable was not modified because Elixir data types are immutable.
> By being immutable, Elixir code is easier to reason about as you never need to worry if a particular code is mutating your data structure in place.

> When “counting” the number of elements in a data structure, Elixir also abides by a simple rule: the function is named size if the operation is in constant time (i.e. the value is pre-calculated) or length if the operation is linear (i.e. calculating the length gets slower as the input grows).

### Sorting
Sort anything, general pragmatism:

http://elixir-lang.org/getting-started/case-cond-and-if.html
number < atom < reference < functions < port < pid < tuple < maps < list < bitstring

```
chcp 65001
```

http://elixir-lang.org/getting-started/modules.html
```elixir
defmodule Math do
  def zero?(0) do
    true
  end

  def zero?(x) when is_number(x) do
    false
  end
end

IO.puts Math.zero?(0)       #=> true
IO.puts Math.zero?(1)       #=> false
IO.puts Math.zero?([1,2,3]) #=> ** (FunctionClauseError)
```

```elixir
defmodule Math do
  def zero?(0), do: true
  def zero?(x) when is_number(x), do: false
end
```
And it will provide the same behaviour. You may use do: for one-liners but always do/end for functions spawning multiple lines.

`function/arity`
arity is the number of parameters a function may take.

```elixir
# sum up
Enum.reduce([1, 2, 3], 0, &+/2) #=> 6
# double each
Enum.map([1, 2, 3], &(&1 * 2)) #=> [2, 4, 6]

iex> odd? = &(rem(&1, 2) != 0)
#Function<6.80484245/1 in :erl_eval.expr/5>
iex> Enum.filter(1..3, odd?)
[1, 3]
```

```elixir
iex> odd? = &(rem(&1, 2) != 0)
iex> Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?))
7500000000
iex> 1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum
7500000000
```
The example above has a pipeline of operations. We start with a range and then multiply each element in the range by 3. This first operation will now create and return a list with 100_000 items. Then we keep all odd elements from the list, generating a new list, now with 50_000 items, and then we sum all entries.

## Streams
```elixir
iex> 1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?)
#Stream<[enum: 1..100000, funs: [...]]>
```
Instead of generating intermediate lists, streams build a series of computations that are invoked only when we pass the underlying stream to the Enum module. Streams are useful when working with large, possibly infinite, collections.
```elixir
iex> stream = Stream.cycle([1, 2, 3])
#Function<15.16982430/2 in Stream.cycle/1>
iex> Enum.take(stream, 10)
[1, 2, 3, 1, 2, 3, 1, 2, 3, 1]
```
