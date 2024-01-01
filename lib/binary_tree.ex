defmodule BinaryTree do
  defstruct node: nil, left: nil, right: nil

  @spec leaves(any()) :: list()
  @doc """
    Enumerates the leaves of the binary tree.

  ## Example
  iex> BinaryTree.leaves %BinaryTree{node: "a", left: %BinaryTree{node: "b",  left: nil, right: nil}, right: %BinaryTree{node: "c", left: nil, right: nil}}
  ["b", "c"]

  iex> BinaryTree.leaves %BinaryTree{node: "a", left: %BinaryTree{node: "b",  left: nil, right: nil}, right: nil}
  ["b"]
  """
  def leaves(tree) do
    cond do
      tree == nil -> []
      tree.left == nil and tree.right == nil -> [tree.node]
      true -> leaves(tree.left) ++ leaves(tree.right)
    end
  end

  @doc """
    Counts the nodes of a tree

  ## Example
  iex> BinaryTree.count %BinaryTree{node: "x", left: nil, right: %BinaryTree{node: "x", left: nil, right: nil}}
  2
  """
  def count(tree) do
    cond do
      tree == nil -> 0
      tree.left == nil and tree.right == nil -> 1
      true -> 1 + count(tree.right) + count(tree.left)
    end
  end

  @doc """
    Returns true if the left and right children of a tree have almost the same
    number of nodes, no greater than 1. False otherwise.

  ## Example
  iex> BinaryTree.is_balanced %{node: "x", left: nil, right: nil}
  true

  iex> BinaryTree.is_balanced %{node: "x", left: %BinaryTree{node: "x", left: nil, right: nil}, right: nil}
  true

  iex> BinaryTree.is_balanced %{node: "x", left: %BinaryTree{node: "x", left: %BinaryTree{node: "x", left: nil, right: nil}, right: nil}, right: nil}
  false
  """
  def is_balanced(tree) do
    abs(count(tree.left) - count(tree.right)) <= 1
  end

  @doc """
    Returns true is tree a is the mirror of tree b.

  ## Example
  iex> BinaryTree.is_mirror %BinaryTree{node: "x", left: nil, right: nil}, %BinaryTree{node: "x", left: nil, right: nil}
  true

  iex> BinaryTree.is_mirror %BinaryTree{node: "x", left: nil, right: nil}, %BinaryTree{node: "x", left: %BinaryTree{node: "x", left: nil, right: nil}, right: nil}
  false

  iex> BinaryTree.is_mirror %BinaryTree{node: "x", left: nil, right: %BinaryTree{node: "x", left: nil, right: nil}}, %BinaryTree{node: "x", left: %BinaryTree{node: "x", left: nil, right: nil}, right: nil}
  true
  """
  def is_mirror(tree_a, tree_b) do
    case {tree_a, tree_b} do
      {nil, nil} ->
        true

      {%BinaryTree{node: _, left: left_a, right: right_a},
       %BinaryTree{node: _, left: left_b, right: right_b}} ->
        is_mirror(left_a, right_b) && is_mirror(right_a, left_b)

      _ ->
        false
    end
  end

  @doc """
    Determines if the given tree is symmetrical

  ## Example
  iex> BinaryTree.is_symmetric %BinaryTree{node: "x", left: nil, right: nil}
  true

  iex> BinaryTree.is_symmetric %BinaryTree{node: "x", left: nil, right: %BinaryTree{node: "x", left: nil, right: nil}}
  false
  """
  def is_symmetric(tree) do
    is_mirror(tree.left, tree.right)
  end

  @doc """
    Find the height - the maximum count of edges to any leaf node - of a binary tree

  ## Example
  iex(2)> BinaryTree.height %BinaryTree{node: "x", left: nil, right: nil}
  0

  iex(3)> BinaryTree.height %BinaryTree{node: "x", left: %BinaryTree{node: "x", left: nil, right: nil}, right: nil}
  1

  iex(4)> BinaryTree.height %BinaryTree{node: "x", left: %BinaryTree{node: "x", left: nil, right: %BinaryTree{node: "x", left: nil, right: nil}}, right: nil}
  2
  """
  def height(tree) do
    case tree do
      nil ->
        0

      %BinaryTree{node: _, left: l, right: r} ->
        case {l, r} do
          {nil, nil} -> 0
          {l, nil} -> 1 + height(l)
          {nil, r} -> 1 + height(r)
          {l, r} -> 1 + max(height(l), height(r))
        end
    end
  end
end
