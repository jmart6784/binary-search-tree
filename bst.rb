class Node
  attr_accessor :data, :left, :right

  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :root, :data

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@data)
  end

  def build_tree(array)
    
  end

end

ary = Array.new(20) { rand(1..30) }

bst = Tree.new(ary)