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

  def insert(value, node = @root)
    return nil if value == node.data

    if value < node.data

      if node.left.nil?
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    else

      if node.right.nil?
        node.right = Node.new(value)
      else
        insert(value, node.right)
      end
    end
  end

  def minValueNode(node)
    current = node

    # Loop to find left most node
    until current.left.nil?
      current = current.left
    end

    return current
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # node has 1 or 0 children
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      temp = minValueNode(node.right)

      node.data = temp.data

      node.right = delete(temp.data, node.right)
    end

    return node
  end

  def find(value, node = @root)
    return node if node.nil? || node.data === value

    if node.data < value 
      return find(value, node.right)
    else
      return find(value, node.left)
    end

  end

  def level_order(node = root, queue = [])
    print "#{node.data} "
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return if queue.empty?

    level_order(queue.shift, queue)
  end

end

# ary = Array.new(20) { rand(1..30) }
ary = [2, 4, 5, 7, 8, 9, 11, 12, 13, 19, 20, 23, 24, 28, 29]

bst = Tree.new(ary)

bst.insert(1)
bst.delete(1)

# puts bst.inspect

bst.level_order