defmodule BinaryTree do
  defstruct [:val, :left, :right]

  @type tree ::
          %BinaryTree{val: any(), left: tree(), right: tree()}
          | :empty

  @spec leaves(tree()) :: list()
  @doc """
    Enumerates the leaves of the binary tree.

  ## Example
  iex> BinaryTree.leaves %BinaryTree{val: "a", left: %BinaryTree{val: "b",  left: :empty, right: :empty}, right: %BinaryTree{val: "c", left: :empty, right: :empty}}
  ["b", "c"]

  iex> BinaryTree.leaves %BinaryTree{val: "a", left: %BinaryTree{val: "b",  left: :empty, right: :empty}, right: :empty}
  ["b"]
  """
  def leaves(:empty), do: []

  def leaves(tree) do
    case tree do
      %BinaryTree{val: n, left: :empty, right: :empty} -> [n]
      %BinaryTree{val: _, left: l, right: r} -> leaves(l) ++ leaves(r)
    end
  end

  @spec count(tree()) :: non_neg_integer()
  @doc """
    Counts the nodes of a tree

  ## Example
  iex> BinaryTree.count %BinaryTree{val: "x", left: :empty, right: %BinaryTree{val: "x", left: :empty, right: :empty}}
  2
  """
  def count(:empty), do: 0

  def count(tree) do
    case tree do
      %BinaryTree{val: _, left: :empty, right: :empty} -> 1
      %BinaryTree{val: _, left: l, right: r} -> 1 + count(l) + count(r)
    end
  end

  @spec is_balanced(tree()) :: boolean()
  @doc """
    Returns true if the left and right children of a tree have almost the same
    number of nodes, no greater than 1. False otherwise.

  ## Example
  iex> BinaryTree.is_balanced %{val: "x", left: :empty, right: :empty}
  true

  iex> BinaryTree.is_balanced %{val: "x", left: %BinaryTree{val: "x", left: :empty, right: :empty}, right: :empty}
  true

  iex> BinaryTree.is_balanced %{val: "x", left: %BinaryTree{val: "x", left: %BinaryTree{val: "x", left: :empty, right: :empty}, right: :empty}, right: :empty}
  false
  """
  def is_balanced(:empty), do: true

  def is_balanced(tree) do
    abs(count(tree.left) - count(tree.right)) <= 1
  end

  @spec is_mirror(tree(), tree()) :: boolean()
  @doc """
    Returns true is tree a is the mirror of tree b.

  ## Example
  iex> BinaryTree.is_mirror %BinaryTree{val: "x", left: :empty, right: :empty}, %BinaryTree{val: "x", left: :empty, right: :empty}
  true

  iex> BinaryTree.is_mirror %BinaryTree{val: "x", left: :empty, right: :empty}, %BinaryTree{val: "x", left: %BinaryTree{val: "x", left: :empty, right: :empty}, right: :empty}
  false

  iex> BinaryTree.is_mirror %BinaryTree{val: "x", left: :empty, right: %BinaryTree{val: "x", left: :empty, right: :empty}}, %BinaryTree{val: "x", left: %BinaryTree{val: "x", left: :empty, right: :empty}, right: :empty}
  true
  """
  def is_mirror(:empty, :empty), do: true
  def is_mirror(:empty, _), do: false
  def is_mirror(_, :empty), do: false

  def is_mirror(tree_a, tree_b) do
    case {tree_a, tree_b} do
      {%BinaryTree{val: _, left: left_a, right: right_a},
       %BinaryTree{val: _, left: left_b, right: right_b}} ->
        is_mirror(left_a, right_b) && is_mirror(right_a, left_b)

      _ ->
        false
    end
  end

  @spec is_symmetric(tree()) :: boolean()
  @doc """
    Determines if the given tree is symmetrical

  ## Example
  iex> BinaryTree.is_symmetric %BinaryTree{val: "x", left: :empty, right: :empty}
  true

  iex> BinaryTree.is_symmetric %BinaryTree{val: "x", left: :empty, right: %BinaryTree{val: "x", left: :empty, right: :empty}}
  false
  """
  def is_symmetric(:empty), do: true

  def is_symmetric(tree) do
    is_mirror(tree.left, tree.right)
  end

  @spec height(tree()) :: non_neg_integer()
  @doc """
    Find the height - the maximum count of edges to any leaf val - of a binary tree

  ## Example
  iex(2)> BinaryTree.height %BinaryTree{val: "x", left: :empty, right: :empty}
  0

  iex(3)> BinaryTree.height %BinaryTree{val: "x", left: %BinaryTree{val: "x", left: :empty, right: :empty}, right: :empty}
  1

  iex(4)> BinaryTree.height %BinaryTree{val: "x", left: %BinaryTree{val: "x", left: :empty, right: %BinaryTree{val: "x", left: :empty, right: :empty}}, right: :empty}
  2
  """
  def height(:empty), do: 0

  def height(tree) do
    case tree do
      %BinaryTree{val: _, left: :empty, right: :empty} -> 0
      %BinaryTree{val: _, left: l, right: r} -> 1 + max(height(l), height(r))
    end
  end
end
