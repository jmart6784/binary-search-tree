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

  def preorder(node = @root)
    unless node.nil?
      print "#{node.data} "
      preorder(node.left)
      preorder(node.right)
    end
  end
  
  def inorder(node = @root)
    unless node.nil?
      inorder(node.left)
      print "#{node.data} "
      inorder(node.right)
    end
  end

  def postorder(node = @root)
    unless node.nil?
      postorder(node.left)
      postorder(node.right)
      print "#{node.data} "
    end
  end

  def height(node = @root)
    unless node.nil? || node === root
      node = (node.instance_of?(Node) ? find(node.data) : find(node))
    end
    
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node = @root, parent = @root, edges = 0)
    return 0 if node == parent
    return -1 if parent.nil?

    if node < parent.data
      edges += 1
      depth(node, parent.left, edges)
    elsif node > parent.data
      edges += 1
      depth(node, parent.right, edges)
    else
      edges
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
      true
    else
      false
    end
  end

  def inorder_ary(node = root, array = [])
    unless node.nil?
      inorder_ary(node.left, array)
      array << node.data
      inorder_ary(node.right, array)
    end
    array
  end

  def rebalance
    self.data = inorder_ary
    self.root = build_tree(data)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '???   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '????????? ' : '????????? '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '???   '}", true) if node.left
  end

end

ary = Array.new(15) { rand(1..100) }

bst = Tree.new(ary)

puts "BST is balanced? #{bst.balanced?}"

puts "Preorder BST traversal:"
puts bst.preorder

puts "Inorder BST traversal:"
puts bst.inorder

puts "Postorder BST traversal:"
puts bst.postorder

# Make tree unbalanced with new values
puts "Insert more values to unbalance tree"
10.times do
  bst.insert(rand(101..201))
end

puts "BST is balanced? #{bst.balanced?}"

puts "Called bst.rebalance"
bst.rebalance

puts "BST is balanced? #{bst.balanced?}"

puts "Preorder BST traversal:"
puts bst.preorder

puts "Inorder BST traversal:"
puts bst.inorder

puts "Postorder BST traversal:"
puts bst.postorder