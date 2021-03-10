class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.length === 1

    middle = (array.length - 1) / 2

    root_node = Node.new(array[middle])

    root_node.left = build_tree(array[0..middle])
    root_node.right = build_tree(array[(middle + 1).. -1])

    return root_node
  end

  def insert(root, key)
    if root.nil?
      return Node.new(key)
    else

      if root.data === key
        return root
      elsif root.data < key
        root.right = insert(root.right, key)
      else
        root.left = insert(root.left, key)
      end

      return root
    end
  end

end

# ary = Array.new(20) { rand(1..30) }
ary = [2, 4, 5, 7, 8, 9, 11, 12, 13, 19, 20, 23, 24, 28, 29]

bst = Tree.new(ary)

bst.insert(bst.root, 1)

puts bst.inspect