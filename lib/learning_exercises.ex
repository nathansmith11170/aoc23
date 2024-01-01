defmodule Learning do
  @moduledoc """
  Module for OCaml exercises, based on the 99 Lisp Problems.
  Completed in Elixir
  """

  @spec last(list()) :: any()
  @doc """
    Return the last element of a list

  ## Example
  iex> Learning.last [1, 2, 3, 4]
  4
  """
  def last(list) do
    case list do
      [] -> None
      [x] -> x
      [_ | tl] -> last(tl)
    end
  end

  @spec last_two(list()) :: None | [...]
  @doc """
    Return the last two elements of a list

  ## Example
  iex> Learning.last_two ["a", "b", "c", "d"]
  ["c", "d"]
  """
  def last_two(list) do
    case list do
      [] -> None
      [x, y] -> [x, y]
      [_ | tl] -> last_two(tl)
    end
  end

  @spec nth(maybe_improper_list(), any()) :: any()
  @doc """
    Return the nth element of a list

  ## Example
  iex> Learning.nth ["a", "b", "c", "d", "e"], 2
  "c"
  """
  def nth(list, n) do
    case list do
      [] ->
        None

      [hd | tl] ->
        if n == 0 do
          hd
        else
          nth(tl, n - 1)
        end
    end
  end

  defp length_aux(cnt, l) do
    case l do
      [] -> cnt
      [_ | tl] -> length_aux(cnt + 1, tl)
    end
  end

  @spec length(list()) :: non_neg_integer()
  @doc """
    Returns the length of a list

  ## Example
  iex> Learning.length [1, 2, 3, 4]
  4
  """
  def length(list) do
    length_aux(0, list)
  end

  defp reverse_aux(acc, l) do
    case l do
      [] -> acc
      [h | tl] -> reverse_aux([h] ++ acc, tl)
    end
  end

  @spec reverse(list()) :: list()
  @doc """
    Returns a reversed list

  ## Example
  iex> Learning.reverse [1, 2, 3, 4]
  [4, 3, 2, 1]
  """
  def reverse(list) do
    reverse_aux([], list)
  end

  @spec is_palindrome(list()) :: boolean()
  @doc """
    Returns true if the list is a palindrome

  ## Examples
  iex> Learning.is_palindrome ["x", "a", "m", "a", "x"]
  true

  iex> not Learning.is_palindrome [1, 2, 3]
  true
  """
  def is_palindrome(list) do
    list == reverse(list)
  end

  defp flatten_aux(acc, l) do
    case l do
      [] ->
        acc

      [h | tl] ->
        if Kernel.is_list(h) do
          flatten_aux(acc ++ flatten_aux([], h), tl)
        else
          flatten_aux(acc ++ [h], tl)
        end
    end
  end

  @spec flatten(list()) :: list()
  @doc """
    Returns a list containing all nested elements of a list of lists

  ## Example
  iex> Learning.flatten [1, [2, 3, [4, 5, 6]]]
  [1, 2, 3, 4, 5, 6]
  """
  def flatten(list) do
    flatten_aux([], list)
  end

  defp compress_aux(acc, l) do
    case l do
      [] ->
        []

      [lst] ->
        acc ++ [lst]

      [fst | tl] ->
        [snd | _] = tl

        if fst == snd do
          compress_aux(acc, tl)
        else
          compress_aux(acc ++ [fst], tl)
        end
    end
  end

  @spec compress(list()) :: list()
  @doc """
    Removes consecutive duplicates in a list, returning the result.

  ## Example
  iex> Learning.compress [1, 1, 1, 1, 2, 3, 3, 4, 4, 4, 5, 6, 7, 7]
  [1, 2, 3, 4, 5, 6, 7]
  """
  def compress(list) do
    compress_aux([], list)
  end

  defp pack_aux(cur, acc, l) do
    case l do
      [] ->
        []

      [lst] ->
        acc ++ [cur ++ [lst]]

      [fst | tl] ->
        [snd | _] = tl

        if fst == snd do
          pack_aux(cur ++ [fst], acc, tl)
        else
          pack_aux([], acc ++ [cur ++ [fst]], tl)
        end
    end
  end

  @spec pack(list()) :: [[...]]
  @doc """
    Packs elements of a list into sublists.

  ## Example
  iex> Learning.pack [1, 1, 1, 1, 2, 3, 3, 4, 4, 4, 5, 6, 7, 7]
  [[1, 1, 1, 1], [2], [3, 3], [4, 4, 4], [5], [6], [7, 7]]
  """
  def pack(list) do
    pack_aux([], [], list)
  end

  defp rle_aux(tup, acc, l) do
    case l do
      [] ->
        []

      [lst] ->
        acc ++ [{lst, elem(tup, 1) + 1}]

      [fst | tl] ->
        [snd | _] = tl

        if fst == snd do
          rle_aux({fst, elem(tup, 1) + 1}, acc, tl)
        else
          rle_aux({None, 0}, acc ++ [{fst, elem(tup, 1) + 1}], tl)
        end
    end
  end

  @spec rle(list()) :: [{any(), pos_integer()}]
  @doc """
    Uses run-length encoding to encode a list into tuples

  ## Example
  iex> Learning.rle [1, 1, 1, 1, 2, 3, 3, 4, 4, 4, 5, 6, 7, 7]
  [{1, 4}, {2, 1}, {3, 2}, {4, 3}, {5, 1}, {6, 1}, {7, 2}]
  """
  def rle(list) do
    rle_aux({None, 0}, [], list)
  end

  defp rlem_aux(tup, acc, l) do
    case l do
      [] ->
        []

      [lst] ->
        acc ++ [{lst, elem(tup, 1) + 1}]

      [fst | tl] ->
        [snd | _] = tl

        if fst == snd do
          rlem_aux({fst, elem(tup, 1) + 1}, acc, tl)
        else
          if elem(tup, 1) == 0 do
            rlem_aux({None, 0}, acc ++ [fst], tl)
          else
            rlem_aux({None, 0}, acc ++ [{fst, elem(tup, 1) + 1}], tl)
          end
        end
    end
  end

  @spec rlem(list()) :: list()
  @doc """
    Uses run length encoding to encode a list of tuples,
    but only when there is more than one occurrence in a run

  ## Example
  iex> Learning.rlem [1, 1, 1, 1, 2, 3, 3, 4, 4, 4, 5, 6, 7, 7]
  [{1, 4}, 2, {3, 2}, {4, 3}, 5, 6, {7, 2}]
  """
  def rlem(list) do
    rlem_aux({None, 0}, [], list)
  end

  defp expand_tup(acc, t) do
    case t do
      {_, 0} -> acc
      {e, cnt} -> expand_tup(acc ++ [e], {e, cnt - 1})
    end
  end

  defp decode_rle_aux(acc, l) do
    case l do
      [] ->
        acc

      [h | tl] ->
        if Kernel.is_tuple(h) do
          decode_rle_aux(acc ++ expand_tup([], h), tl)
        else
          decode_rle_aux(acc ++ [h], tl)
        end
    end
  end

  @spec decode_rle(list()) :: list()
  @doc """
    Decodes a run-length encoded list into the original list

  ## Example
  iex> Learning.decode_rle [{1, 4}, {2, 1}, {3, 2}, {4, 3}, {5, 1}, {6, 1}, {7, 2}]
  [1, 1, 1, 1, 2, 3, 3, 4, 4, 4, 5, 6, 7, 7]
  """
  def decode_rle(list) do
    decode_rle_aux([], list)
  end

  @spec duplicate(list()) :: list()
  @doc """
    Duplicate elements of a list

  ## Example
  iex> Learning.duplicate ["a", "b", "c", "d", "e"]
  ["a", "a", "b", "b", "c", "c", "d", "d", "e", "e"]
  """
  def duplicate(list) do
    case list do
      [] -> []
      [h | tl] -> [h, h] ++ duplicate(tl)
    end
  end

  @spec replicate(list(), any()) :: list()
  @doc """
    Replicate elements of a list n times

  ## Example
  iex> Learning.replicate ["a", "b", "c", "d", "e"], 3
  ["a", "a", "a", "b", "b", "b", "c", "c", "c", "d", "d", "d", "e", "e", "e"]
  """
  def replicate(list, n) do
    case list do
      [] -> []
      [h | tl] -> expand_tup([], {h, n}) ++ replicate(tl, n)
    end
  end

  defp drop_every_aux(acc, cnt, list, n) do
    case list do
      [] ->
        acc

      [h | tl] ->
        if rem(cnt, n) == 0 do
          drop_every_aux(acc, cnt + 1, tl, n)
        else
          drop_every_aux(acc ++ [h], cnt + 1, tl, n)
        end
    end
  end

  @spec drop_every(list(), any()) :: list()
  @doc """
    Drop every N'th element from a list.

  ## Example
  iex> Learning.drop_every [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 3
  [1, 2, 4, 5, 7, 8, 10, 11]
  """
  def drop_every(list, n) do
    drop_every_aux([], 1, list, n)
  end

  defp split_at_aux(acc, cnt, list, n) do
    case list do
      [] ->
        [acc, []]

      [h | tl] ->
        if cnt < n do
          split_at_aux(acc ++ [h], cnt + 1, tl, n)
        else
          [acc, [h] ++ tl]
        end
    end
  end

  @spec split_at(maybe_improper_list(), any()) :: [maybe_improper_list(), ...]
  @doc """
    Split a list into two parts; the length of the first part is given.

    If the length of the first part is longer than the entire list,
    then the first part is the list and the second part is empty.

  ## Example
  iex(30)> Learning.split_at [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 3
  [[1, 2, 3], [4, 5, 6, 7, 8, 9, 10, 11]]

  iex(31)> Learning.split_at [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 30
  [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], []]
  """
  def split_at(list, n) do
    split_at_aux([], 0, list, n)
  end

  defp slice_aux(acc, cnt, list, lower, upper) do
    case list do
      [] ->
        acc

      [h | tl] ->
        cond do
          cnt < lower -> slice_aux(acc, cnt + 1, tl, lower, upper)
          cnt <= upper -> slice_aux(acc ++ [h], cnt + 1, tl, lower, upper)
          true -> acc
        end
    end
  end

  @spec slice(maybe_improper_list(), any(), any()) :: list()
  @doc """
    Given two indices, i and k, the slice is the list containing the elements
    between the i'th and k'th element of the original list (both limits included)

  ## Example
  iex> Learning.slice [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 2, 6
  [3, 4, 5, 6, 7]
  """
  def slice(list, lower, upper) do
    slice_aux([], 0, list, lower, upper)
  end

  @spec rotate_left(maybe_improper_list(), integer()) :: maybe_improper_list()
  @doc """
    Rotate a list N places to the left.

  ## Example
  iex(33)> Learning.rotate_left [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 5
  [6, 7, 8, 9, 10, 11, 1, 2, 3, 4, 5]

  iex(34)> Learning.rotate_left [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 50
  [7, 8, 9, 10, 11, 1, 2, 3, 4, 5, 6]
  """
  def rotate_left(list, n) do
    [left, right] = split_at(list, rem(n, Enum.count(list)))
    right ++ left
  end

  defp remove_kth_aux(acc, cnt, list, k) do
    case list do
      [] ->
        acc

      [h | tl] ->
        if cnt != k do
          remove_kth_aux(acc ++ [h], cnt + 1, tl, k)
        else
          remove_kth_aux(acc, cnt + 1, tl, k)
        end
    end
  end

  @spec remove_kth(list(), integer()) :: list()
  @doc """
    Remove the K'th element from a list.

  ## Example
  iex(35)> Learning.remove_kth [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 5
  [1, 2, 3, 4, 5, 7, 8, 9, 10, 11]
  """
  def remove_kth(list, k) when is_integer(k) do
    remove_kth_aux([], 0, list, k)
  end

  @spec insert_at(any(), integer(), maybe_improper_list()) :: nonempty_maybe_improper_list()
  @doc """
    Insert element at the given position. If the position is larger or equal to
    the length of the list, insert the element at the end. (The behavior is
    unspecified if the position is negative.)

  ## Example
  iex(36)> Learning.insert_at 5, 4, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
  [1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10, 11]
  """
  def insert_at(e, n, list) when is_integer(n) and is_list(list) do
    case list do
      [] ->
        list ++ [e]

      [h | tl] ->
        if n == 0 do
          [e] ++ [h] ++ tl
        else
          [h] ++ insert_at(e, n - 1, tl)
        end
    end
  end

  @spec range(integer(), integer()) :: [integer()]
  @doc """
    Create a list containing all integers in a given range

  ## Example
  iex(37)> Learning.range 4, 9
  [4, 5, 6, 7, 8, 9]
  """
  def range(low, high) when is_integer(low) and is_integer(high) do
    cond do
      low <= high -> [low] ++ range(low + 1, high)
      low > high -> []
    end
  end

  defp rand_select_aux(cnt, list, n) do
    cond do
      cnt < n ->
        [Enum.at(list, trunc((Enum.count(list) - 1) * :rand.uniform()))] ++
          rand_select_aux(cnt + 1, list, n)

      cnt >= n ->
        []
    end
  end

  @spec rand_select(maybe_improper_list(), integer()) :: list()
  @doc """
    Extract a number of randomly selected elements from a list

  ## Example
  iex(46)> :rand.seed(:default, 0)
  iex(47)> Learning.rand_select [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 3
  [5, 4, 10]
  """
  def rand_select(list, n) when is_list(list) and is_integer(n) do
    rand_select_aux(0, list, n)
  end

  defp lotto_draw_aux(cnt, n, max) do
    cond do
      cnt < n -> [trunc((max - 1) * :rand.uniform())] ++ lotto_draw_aux(cnt + 1, n, max)
      cnt >= n -> []
    end
  end

  @spec lotto_draw(integer(), integer()) :: [integer()]
  @doc """
    Draw n random numbers from the set 1..max

  ## Example
  iex> :rand.seed(:default, 0)
  iex> Learning.lotto_draw 5, 100
  [47, 29, 98, 61, 14]
  """
  def lotto_draw(n, max) when is_integer(n) and is_integer(max) do
    lotto_draw_aux(0, n, max)
  end

  @spec swap(maybe_improper_list(), integer(), integer()) :: [...]
  @doc """
    Swap the elements of a list at positions i and j

  ## Example
  iex> Learning.swap [1, 2, 3, 4, 5, 6], 2, 4
  [1, 2, 5, 4, 3, 6]
  """
  def swap(l, i, j) when is_list(l) and is_integer(i) and is_integer(j) do
    case Enum.split(l, i) do
      {up_to_i, [elem_i | rest]} ->
        case Enum.split(rest, max(max(j, i) - min(j, i) - 1, 0)) do
          {between_i_and_j, [elem_j | after_j]} ->
            up_to_i ++ [elem_j] ++ between_i_and_j ++ [elem_i] ++ after_j

          {_, []} ->
            raise "Index #{j - i} out of bounds #{Enum.count(rest)}"
        end

      {_, []} ->
        raise "Index #{i} out of bounds #{Enum.count(l)}"
    end
  end

  defp shuffle_aux(n, list) do
    j = Enum.random(1..(n - 1))

    cond do
      n > 1 -> shuffle_aux(n - 1, swap(list, j, n))
      n <= 1 -> list
    end
  end

  @doc """
    Shuffles a list.

  ## Example
  iex> :rand.seed(:default, 0)
  iex> Learning.shuffle [1, 2, 3, 4, 5, 6]
  [1, 3, 4, 6, 2, 5]
  """
  def shuffle(list) when is_list(list) do
    shuffle_aux(Enum.count(list) - 1, list)
  end

  @doc """
    Generate the combinations of n elements taken from the list k.

  ## Example
  iex> Learning.extract 2, [1, 2, 3, 4, 5]
  [
    [1, 2],
    [1, 3],
    [1, 4],
    [1, 5],
    [2, 3],
    [2, 4],
    [2, 5],
    [3, 4],
    [3, 5],
    [4, 5]
  ]
  """
  def extract(n, k) when is_integer(n) and is_list(k) do
    if n == 0 do
      [[]]
    else
      case k do
        [] ->
          []

        [h | tl] ->
          with_h = extract(n - 1, tl) |> Enum.map(fn l -> [h | l] end)
          wihtout_h = extract(n, tl)
          with_h ++ wihtout_h
      end
    end
  end

  @spec group(maybe_improper_list(), maybe_improper_list()) :: list()
  @doc """
    Groups elements of a list into disjoint subsets

  ## Example
  iex> Learning.group ["a", "b", "c", "d"], [2, 1]
  [
    [{"a", "b"}, {"c"}],
    [{"a", "b"}, {"d"}],
    [{"a", "c"}, {"b"}],
    [{"a", "c"}, {"d"}],
    [{"a", "d"}, {"b"}],
    [{"a", "d"}, {"c"}],
    [{"b", "c"}, {"a"}],
    [{"b", "c"}, {"d"}],
    [{"b", "d"}, {"a"}],
    [{"b", "d"}, {"c"}],
    [{"c", "d"}, {"a"}],
    [{"c", "d"}, {"b"}]
  ]

  How many ways can a group of 9 people be organized into groups of 2, 3, and 4?
  iex> Enum.count(Learning.group ["a", "b", "c", "d", "e", "f", "g", "h", "i"], [2, 3, 4])
  1260
  """
  def group(lst, subsets) when is_list(lst) and is_list(subsets) do
    for(
      n <- subsets,
      do: extract(n, lst)
    )
    |> Enum.map(fn l -> Enum.map(l, fn m -> List.to_tuple(m) end) end)
    |> n_ary_cartesian_product
    |> Enum.filter(fn x ->
      Enum.uniq(Enum.concat(Enum.map(x, &Tuple.to_list/1))) ==
        Enum.concat(Enum.map(x, &Tuple.to_list/1))
    end)
  end

  @spec cartesian_product(maybe_improper_list(), maybe_improper_list()) :: list()
  @doc """
    Calculate the cartesian product of sets a and b, represented as lists

  ## Example
  iex> Learning.cartesian_product [:a, :b], [1, 2, 3]
  [[:a, 1], [:a, 2], [:a, 3], [:b, 1], [:b, 2], [:b, 3]]
  """
  def cartesian_product(set_a, set_b) when is_list(set_a) and is_list(set_b) do
    Enum.flat_map(set_a, fn a -> for(b <- set_b, do: [a, b]) end)
  end

  @spec n_ary_cartesian_product([maybe_improper_list()]) :: list()
  @doc """
    Calculate the cartesian product of any n number of sets represented as lists

  ## Examples
  iex> Learning.n_ary_cartesian_product [[1, 2], [:a, :b], ["c", "d"]]
  [
    [1, :a, "c"],
    [1, :a, "d"],
    [1, :b, "c"],
    [1, :b, "d"],
    [2, :a, "c"],
    [2, :a, "d"],
    [2, :b, "c"],
    [2, :b, "d"]
  ]
  """
  def n_ary_cartesian_product(sets) do
    case sets do
      [] ->
        []

      [fst, snd] ->
        cartesian_product(fst, snd) |> Enum.map(&List.flatten/1)

      [fst | [snd | tl]] ->
        n_ary_cartesian_product([cartesian_product(fst, snd) | tl])
    end
  end

  @spec are_disjoint(maybe_improper_list(), maybe_improper_list()) :: boolean()
  @doc """
    Returns true if list a and list b have no common elements.

  ## Examples
  iex> Learning.are_disjoint [1, 2, 3], [4, 5, 6]
  true

  iex> Learning.are_disjoint [1, 2, 3], [4, 5, 1]
  false
  """
  def are_disjoint(a, b) when is_list(a) and is_list(b) do
    Enum.all?(b, fn e -> not Enum.member?(a, e) end)
  end

  @spec n_ary_are_disjoint(maybe_improper_list()) :: boolean()
  @doc """
    Returns true if all the lists in s have no common elements with all others in s.

  ## Example
  iex> Learning.n_ary_are_disjoint [[1, 2], [:a, :b], ["c", "d"]]
  true

  iex> Learning.n_ary_are_disjoint [[1, 2], [:a, :b], ["c", "d"], [2, 3]]
  false
  """
  def n_ary_are_disjoint(s) when is_list(s) do
    all_pairs =
      for set_a <- s, set_b <- s -- [set_a], do: are_disjoint(set_a, set_b)

    Enum.all?(all_pairs)
  end

  @spec length_sort(maybe_improper_list()) :: list()
  @doc """
    Sorts a list of lists by length of each element list.

  ## Example
  iex> Learning.length_sort [[1, 2, 3, 4], [5, 6, 7], [8], [8, 10], [11, 12, 13, 14, 51]]
  [[8], [8, 10], [5, 6, 7], [1, 2, 3, 4], [11, 12, 13, 14, 51]]
  """
  def length_sort(enums) when is_list(enums) do
    Enum.sort(enums, fn e1, e2 ->
      Enum.count(e1) < Enum.count(e2)
    end)
  end

  @spec count_length_frequency(maybe_improper_list(), integer()) :: any()
  @doc """
    Counts the occurrences of lists with specified length in a list of lists.

  ## Example
  iex> Learning.count_length_frequency [[1, 2], [:a, :b], ["c", "d"]], 2
  3
  """
  def count_length_frequency(enums, length) when is_list(enums) and is_integer(length) do
    Enum.reduce(enums, 0, fn e, acc ->
      if Enum.count(e) == length do
        acc + 1
      else
        acc
      end
    end)
  end

  @doc """
    Sorts a list of lists by the frequency of the length of each element.
    Lower frequency lengths are first.

    For tiebreaker, default to length of lists.

  ## Example
  iex> Learning.frequency_sort [["a", "b", "c"], ["d", "e"], ["f", "g", "h"], ["d", "e"], ["i", "j", "k", "l"], ["m", "n"], ["o"]]
  [
    ["o"],
    ["i", "j", "k", "l"],
    ["f", "g", "h"],
    ["a", "b", "c"],
    ["m", "n"],
    ["d", "e"],
    ["d", "e"]
  ]
  """
  def frequency_sort(enums) do
    Enum.sort(enums, fn e1, e2 ->
      freq1 = count_length_frequency(enums, Enum.count(e1))
      freq2 = count_length_frequency(enums, Enum.count(e2))

      if freq1 != freq2 do
        freq1 < freq2
      else
        Enum.count(e1) < Enum.count(e2)
      end
    end)
  end

  @spec is_prime(integer()) :: boolean()
  @doc """
    Returns true if n is prime, false otherwise

  ## Example
  iex> Learning.is_prime 1
  false

  iex> Learning.is_prime 2
  true

  iex> Learning.is_prime 3
  true

  iex> Learning.is_prime 4
  false

  iex> Learning.is_prime 5
  true

  iex> Learning.is_prime 6
  false

  iex> Learning.is_prime 7
  true

  iex> Learning.is_prime 8
  false

  iex> Learning.is_prime 9
  false

  iex> Learning.is_prime 0
  false
  """
  def is_prime(n) when is_integer(n) do
    cond do
      n == 1 ->
        false

      n == 2 || n == 3 ->
        true

      true ->
        are_factors = for i <- 2..(trunc(:math.sqrt(n)) + 1), into: [], do: rem(n, i) == 0
        not Enum.any?(are_factors)
    end
  end

  @spec divisors(integer()) :: MapSet.t()
  @doc """
    Returns the divisors of integer n

  ## Example
  iex> Learning.divisors 68
  MapSet.new([1, 2, 4, 17, 34, 68])
  """
  def divisors(n) when is_integer(n) do
    MapSet.new(for i <- 1..n, rem(n, i) == 0, do: i)
  end

  @spec gcd(integer(), integer()) :: any()
  @doc """
    Returns the greatest common divisor of n and m

  ## Example
  iex> Learning.gcd 13, 27
  1
  iex> Learning.gcd 20536, 7826
  2
  """
  def gcd(n, m) when is_integer(n) and is_integer(m) do
    n_divisors = divisors(n)
    m_divisors = divisors(m)
    MapSet.intersection(n_divisors, m_divisors) |> MapSet.to_list() |> Enum.max()
  end

  @spec coprime(integer(), integer()) :: boolean()
  @doc """
    Returns true if integers n and m are coprime, false otherwise.

  ## Example
  iex> Learning.coprime 13, 27
  true
  iex> Learning.coprime 20536, 7826
  false
  """
  def coprime(n, m) when is_integer(n) and is_integer(m) do
    gcd(n, m) == 1
  end

  @spec phi(integer()) :: non_neg_integer()
  @doc """
    Calculate Euler's totient function of n

  ## Example
  iex> Learning.phi 10
  4
  """
  def phi(n) when is_integer(n) do
    for(
      i <- 1..n,
      coprime(n, i),
      do: i
    )
    |> Enum.count()
  end

  defp first_factor(i, n) when is_integer(i) and is_integer(n) do
    cond do
      n == 2 -> {1, 2}
      rem(n, i) == 0 -> {i, div(n, i)}
      i >= trunc(:math.sqrt(n)) + 1 -> {1, n}
      true -> first_factor(i + 1, n)
    end
  end

  defp any_factors(n) when is_integer(n) do
    first_factor(2, n)
  end

  @spec construct_factors_tree(integer()) :: %BinaryTree{
          node: integer(),
          left: nil | %BinaryTree{},
          right: nil | %BinaryTree{}
        }
  @doc """
    Construct a factors tree for integer n.

  ## Example
  iex> Learning.construct_factors_tree 315
  %BinaryTree{
    node: 315,
    left: %BinaryTree{node: 3, left: nil, right: nil},
    right: %BinaryTree{
      node: 105,
      left: %BinaryTree{node: 3, left: nil, right: nil},
      right: %BinaryTree{
        node: 35,
        left: %BinaryTree{node: 5, left: nil, right: nil},
        right: %BinaryTree{node: 7, left: nil, right: nil}
      }
    }
  }
  """
  def construct_factors_tree(n) when is_integer(n) do
    {factor_l, factor_r} = any_factors(n)

    %BinaryTree{
      node: n,
      left:
        if factor_l == 1 do
          nil
        else
          construct_factors_tree(factor_l)
        end,
      right:
        if factor_r == n do
          nil
        else
          construct_factors_tree(factor_r)
        end
    }
  end

  @spec prime_factors(integer()) :: list()
  @doc """
    List the prime factors of n

  ## Example
  iex> Learning.prime_factors 315
  [3, 3, 5, 7]
  """
  def prime_factors(n) when is_integer(n) do
    construct_factors_tree(n) |> BinaryTree.leaves() |> Enum.sort()
  end

  @spec prime_factors_rle(integer()) :: [{any(), pos_integer()}]
  @doc """
    List the prime factors of n, run-length encoded.

  ## Example
  iex> Learning.prime_factors_rle 315
  [{3, 2}, {5, 1}, {7, 1}]
  """
  def prime_factors_rle(n) when is_integer(n) do
    construct_factors_tree(n) |> BinaryTree.leaves() |> Enum.sort() |> rle()
  end

  @spec totient_improved(integer()) :: any()
  @doc """
    Calculate Euler's totient efficiently, instead of naive implementation

  ## Example
  iex> Learning.totient_improved 10
  4
  """
  def totient_improved(n) when is_integer(n) do
    prime_factors_rle(n)
    |> Enum.reduce(1, fn {p, m}, acc -> acc * (p - 1) * trunc(:math.pow(p, m - 1)) end)
  end

  @spec all_primes(integer(), integer()) :: list()
  @doc """
    List all primes in a range

  ## Example
  iex> Learning.all_primes 2, 100
  [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67,
  71, 73, 79, 83, 89, 97]
  """
  def all_primes(lower, upper) do
    for i <- lower..upper, is_prime(i), do: i
  end

  defp prime_addends(n, i) do
    cond do
      i == 0 -> {}
      is_prime(i) && is_prime(n - i) -> {i, n - i}
      true -> prime_addends(n, i - 1)
    end
  end

  @spec goldbachs(integer()) :: nil | {} | {integer(), integer()}
  @doc """
    Return two prime addends for integer n

  ## Example
  iex> Learning.goldbachs 54
  {47, 7}
  """
  def goldbachs(n) when is_integer(n) do
    cond do
      not (rem(n, 2) == 0) ->
        nil

      n <= 2 ->
        nil

      true ->
        prime_addends(n, n - 1)
    end
  end

  @spec goldbach_list(integer(), integer()) :: list()
  @doc """
    Find the two prime addends for every even integer in the range

  ## Example
  iex> Learning.goldbach_list 3, 25
  [
    {4, {2, 2}},
    {6, {3, 3}},
    {8, {5, 3}},
    {10, {7, 3}},
    {12, {7, 5}},
    {14, {11, 3}},
    {16, {13, 3}},
    {18, {13, 5}},
    {20, {17, 3}},
    {22, {19, 3}},
    {24, {19, 5}}
  ]
  """
  def goldbach_list(lower, upper) when is_integer(lower) and is_integer(upper) do
    for i <- lower..upper, rem(i, 2) == 0, do: {i, goldbachs(i)}
  end

  @doc """
    Given a tagged struct representing a boolean expression, evaluate it

  ## Example
  iex> Learning.eval_bool_expr {:and, {{:var, true}, {:var, false}}}
  false

  iex> Learning.eval_bool_expr {:or, {{:var, true}, {:var, false}}}
  true
  """
  def eval_bool_expr(expr) do
    {tag, expr} = expr

    case tag do
      :and ->
        {l, r} = expr
        eval_bool_expr(l) && eval_bool_expr(r)

      :or ->
        {l, r} = expr
        eval_bool_expr(l) || eval_bool_expr(r)

      :not ->
        not eval_bool_expr(expr)

      :var ->
        expr
    end
  end

  @doc """
    Given a tagged struct representing a boolean expression, replace the
    variable specified with the value

  ## Example
  iex> Learning.bool_substitution {:var, "a"}, "a", true
  {:var, true}
  """
  def bool_substitution(expr, var, val) do
    {tag, _} = expr

    case tag do
      :and ->
        {_, e} = expr
        {l, r} = e
        {:and, {bool_substitution(l, var, val), bool_substitution(r, var, val)}}

      :or ->
        {_, e} = expr
        {l, r} = e
        {:or, {bool_substitution(l, var, val), bool_substitution(r, var, val)}}

      :not ->
        {_, e} = expr
        {:not, bool_substitution(e, var, val)}

      :var ->
        {_, v} = expr
        if v == var, do: {:var, val}, else: expr
    end
  end

  @doc """
    Given a tagged struct representing a boolean expression with 2 variables,
    generate a truth table.

  ## Example
  iex> Learning.table2 "a", "b", {:and, {{:var, "a"}, {:var, "b"}}}
  [
    {false, false, false},
    {false, true, false},
    {true, false, false},
    {true, true, true}
  ]
  """
  def table2(a, b, expr) do
    for i <- [false, true],
        j <- [false, true],
        do:
          (
            result =
              bool_substitution(expr, a, i) |> bool_substitution(b, j) |> eval_bool_expr()

            {i, j, result}
          )
  end

  @doc """
    Given a list of tuples contianing variables and values, perform substition
    for a boolean expression represented as a tagged struct.

  ## Example
  iex> Learning.bool_sub_list [{"a", true}, {"b", false}], {:and, {{:var, "a"}, {:var, "b"}}}
  {:and, {{:var, true}, {:var, false}}}
  """
  def bool_sub_list(vals, expr) do
    {tag, _} = expr

    case tag do
      :and ->
        {_, e} = expr
        {l, r} = e
        {:and, {bool_sub_list(vals, l), bool_sub_list(vals, r)}}

      :or ->
        {_, e} = expr
        {l, r} = e
        {:or, {bool_sub_list(vals, l), bool_sub_list(vals, r)}}

      :not ->
        {_, e} = expr
        {:not, {bool_sub_list(vals, e)}}

      :var ->
        {_, v} = expr
        val = elem(Enum.find(vals, nil, fn {k, _} -> k == v end), 1)

        if val != nil,
          do: {:var, val},
          else: expr
    end
  end

  @doc """
    Generate a truth table for a boolean expression with n variables

  ## Example
  iex> Learning.table ["a", "b", "c"], {:and, {{:var, "a"}, {:or, {{:var, "b"}, {:var, "c"}}}}}
  [
    {[{"a", true}, {"b", true}, {"c", true}], true},
    {[{"a", true}, {"b", true}, {"c", false}], true},
    {[{"a", true}, {"b", false}, {"c", true}], true},
    {[{"a", true}, {"b", false}, {"c", false}], false},
    {[{"a", false}, {"b", true}, {"c", true}], false},
    {[{"a", false}, {"b", true}, {"c", false}], false},
    {[{"a", false}, {"b", false}, {"c", true}], false},
    {[{"a", false}, {"b", false}, {"c", false}], false}
  ]
  """
  def table(vars, expr) do
    val_combinations =
      Enum.map(vars, fn _ -> [true, false] end)
      |> n_ary_cartesian_product()

    for c <- val_combinations,
        do:
          (
            vals = Enum.zip(vars, c)

            {vals, vals |> bool_sub_list(expr) |> eval_bool_expr()}
          )
  end

  @spec gray(integer()) :: list()
  @doc """
    Generate the gray code for an integer.

    In this case, the result is all the binary numbers that can be represented in n bits

  ## Example
  iex> Learning.gray 3
  ["000", "001", "010", "011", "100", "101", "110", "111"]
  """
  def gray(n) when is_integer(n) do
    for _i <-
          1..n do
      ["0", "1"]
    end
    |> n_ary_cartesian_product()
    |> Enum.map(&List.to_string/1)
  end

  defp smallest_two(queue_1, queue_2, acc) do
    cond do
      Enum.count(acc) >= 2 ->
        [acc, queue_1, queue_2]

      queue_1 == [] ->
        [fst | rest] = queue_2
        smallest_two(queue_1, rest, [fst | acc])

      queue_2 == [] ->
        [fst | rest] = queue_1
        smallest_two(rest, queue_2, [fst | acc])

      true ->
        [fst | rest] = queue_1
        [fst2 | rest2] = queue_2

        if elem(fst.node, 1) <= elem(fst2.node, 1) do
          smallest_two(rest, queue_2, [fst | acc])
        else
          smallest_two(queue_1, rest2, [fst2 | acc])
        end
    end
  end

  @doc """
    Constructs the huffman tree, given the initial priority queues of the alphabet

    While there is more than one node in the queue:

        Remove the two nodes of highest priority (lowest probability) from the queue
        Create a new internal node with these two nodes as children and with probability equal to the sum of the two nodes' probabilities.
        Add the new node to the queue.

    The remaining node is the root node and the tree is complete.
  """
  def construct_huffman_tree(queue_1, queue_2) do
    cond do
      Enum.count(queue_1) + Enum.count(queue_2) > 1 ->
        [[smallest, small], remaining_1, remaining_2] = smallest_two(queue_1, queue_2, [])

        new_node = %BinaryTree{
          node: {"", elem(smallest.node, 1) + elem(small.node, 1)},
          left: smallest,
          right: small
        }

        construct_huffman_tree(remaining_1, remaining_2 ++ [new_node])

      true ->
        Enum.at(queue_2, 0)
    end
  end

  @doc """
    Traverse the huffman tree, labeling the edges, and return the complete code
    for each leaf of the tree
  """
  def enumerate_huffman_code(tree, code) do
    cond do
      tree.left == nil && tree.right == nil ->
        [{elem(tree.node, 0), code}]

      true ->
        enumerate_huffman_code(tree.left, code <> "1") ++
          enumerate_huffman_code(tree.right, code <> "0")
    end
  end

  @doc """
    Construct and return the huffman encoded alphabet.

  ## Example
  iex> Learning.huffman [{"a", 45}, {"b", 13}, {"c", 12}, {"d", 16}, {"e", 9}, {"f", 5}]
  [
    {"d", "111"},
    {"e", "1101"},
    {"f", "1100"},
    {"b", "101"},
    {"c", "100"},
    {"a", "0"}
  ]
  """
  def huffman(alphabet) when is_list(alphabet) do
    for(
      {symbol, weight} <- alphabet,
      do: %BinaryTree{node: {symbol, weight}, left: nil, right: nil}
    )
    |> Enum.sort(fn a, b -> elem(a.node, 1) <= elem(b.node, 1) end)
    |> construct_huffman_tree([])
    |> enumerate_huffman_code("")
  end

  defp add_trees_with(left, right) do
    for l <- left, r <- right, do: %BinaryTree{node: "x", left: l, right: r}
  end

  @doc """
    Construct all possible balanced binary trees with count nodes.

  ## Example
  iex> Learning.construct_balanced_btrees 4
  [
    %BinaryTree{
      node: "x",
      left: %BinaryTree{node: "x", left: nil, right: nil},
      right: %BinaryTree{
        node: "x",
        left: nil,
        right: %BinaryTree{node: "x", left: nil, right: nil}
      }
    },
    %BinaryTree{
      node: "x",
      left: %BinaryTree{node: "x", left: nil, right: nil},
      right: %BinaryTree{
        node: "x",
        left: %BinaryTree{node: "x", left: nil, right: nil},
        right: nil
      }
    },
    %BinaryTree{
      node: "x",
      left: %BinaryTree{
        node: "x",
        left: nil,
        right: %BinaryTree{node: "x", left: nil, right: nil}
      },
      right: %BinaryTree{node: "x", left: nil, right: nil}
    },
    %BinaryTree{
      node: "x",
      left: %BinaryTree{
        node: "x",
        left: %BinaryTree{node: "x", left: nil, right: nil},
        right: nil
      },
      right: %BinaryTree{node: "x", left: nil, right: nil}
    }
  ]
  """
  def construct_balanced_btrees(count) do
    cond do
      count == 0 ->
        [nil]

      rem(count, 2) == 1 ->
        t = construct_balanced_btrees(trunc(count / 2))
        add_trees_with(t, t)

      rem(count, 2) == 0 ->
        t1 = construct_balanced_btrees(trunc(count / 2) - 1)
        t2 = construct_balanced_btrees(trunc(count / 2))
        add_trees_with(t1, t2) ++ add_trees_with(t2, t1)
    end
  end

  defp bst_insert(z, tree) do
    case tree do
      nil ->
        %BinaryTree{node: z, left: nil, right: nil}

      %BinaryTree{node: n, left: l, right: r} ->
        cond do
          n == z -> tree
          z < n -> %BinaryTree{node: n, left: bst_insert(z, l), right: r}
          z > n -> %BinaryTree{node: n, left: l, right: bst_insert(z, r)}
        end
    end
  end

  @spec construct_bst(list()) :: any()
  @doc """
    Construct a binary search tree from a list of orderable elements

  ## Example
  iex> Learning.construct_bst [3, 2, 5, 7, 1]
  %BinaryTree{
    node: 3,
    left: %BinaryTree{
      node: 2,
      left: %BinaryTree{node: 1, left: nil, right: nil},
      right: nil
    },
    right: %BinaryTree{
      node: 5,
      left: nil,
      right: %BinaryTree{node: 7, left: nil, right: nil}
    }
  }
  """
  def construct_bst(xs) when is_list(xs) do
    List.foldl(xs, nil, &bst_insert/2)
  end

  @doc """
    Construct all symmetrical, balanced binary trees with n nodes

  ## Example
  iex> Enum.count(Learning.sym_bal_btrees(57))
  256
  """
  def sym_bal_btrees(n) do
    construct_balanced_btrees(n)
    |> Enum.filter(&BinaryTree.is_symmetric/1)
  end

  @doc """
    Construct all height-balanced binary trees with height h

  ## Example
  iex(63)> Learning.construct_height_balanced_btrees(2) |> Enum.map(&BinaryTree.height/1)
  [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
  """
  def construct_height_balanced_btrees(h) do
    cond do
      h == 0 ->
        [%BinaryTree{node: "x", left: nil, right: nil}]

      h == 1 ->
        [
          %BinaryTree{node: "x", left: %BinaryTree{node: "x", left: nil, right: nil}, right: nil},
          %BinaryTree{node: "x", left: nil, right: %BinaryTree{node: "x", left: nil, right: nil}},
          %BinaryTree{
            node: "x",
            left: %BinaryTree{node: "x", left: nil, right: nil},
            right: %BinaryTree{node: "x", left: nil, right: nil}
          }
        ]

      true ->
        t1 = construct_height_balanced_btrees(h - 1)
        t2 = construct_height_balanced_btrees(h - 2)

        add_trees_with(t1, t1) ++ add_trees_with(t1, t2) ++ add_trees_with(t2, t1)
    end
  end

  @doc """
    Find and return the minimum number of nodes for a height-balanced binary
    tree of the given height

  ## Example
  iex(70)> Learning.min_nodes 3
  5
  """
  def min_nodes(0) do
    # A tree with no children
    1
  end

  def min_nodes(1) do
    # A tree with one edge is still height-balanced
    2
  end

  def min_nodes(h) when is_integer(h) do
    # the nodes of the left and right children, this is always less than if
    # both children have height h-1 so that case can be ignored
    min_nodes(h - 1) + min_nodes(h - 2)
  end

  @doc """
    Find and return the minumum height for a height-balanced binary tree with
    the given number of nodes

  ## Examples
  iex(80)> Learning.min_height 1
  0

  iex(81)> Learning.min_height 2
  1

  iex(82)> Learning.min_height 3
  1

  iex(83)> Learning.min_height 4
  2

  iex(84)> Learning.min_height 5
  2

  iex(85)> Learning.min_height 6
  2

  iex(86)> Learning.min_height 7
  2

  iex(87)> Learning.min_height 8
  3

  iex(88)> Learning.min_height 9
  3

  iex(89)> Learning.min_height 10
  3

  iex(90)> Learning.min_height 11
  3

  iex(91)> Learning.min_height 12
  3

  iex(92)> Learning.min_height 13
  3

  iex(93)> Learning.min_height 14
  3

  iex(94)> Learning.min_height 15
  3

  iex(95)> Learning.min_height 16
  4
  """
  def min_height(n) when is_integer(n) do
    trunc(:math.log2(n))
  end
end
