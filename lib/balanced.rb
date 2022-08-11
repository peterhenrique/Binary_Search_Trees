# frozen_string_literal: true

require 'pry-byebug'

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def comparable(next_node)
    data == next_node.data
  end
end

class Tree
  attr_accessor :root, :data

  def initialize(data)
    data = data.sort.uniq
    @data = data
    @root = build_tree(data)
  end

  def build_tree(arr)
    return nil if arr.empty?

    arr = arr.uniq.sort
    mid = (arr.size - 1) / 2
    root_node = Node.new(arr[mid])
    root_node.left = build_tree(arr[0...mid])
    root_node.right = build_tree(arr[mid + 1..])
    root_node
  end

  def insert(value, node = @root)
    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    if value < node.data
      node.left.left.nil? ? node.left = node.left.right : delete(value, node.left)
    elsif value > node.data
      node.right.right.nil? ? node.right = node.right.left : delete(value, node.right)
    elsif !node.left.nil? && !node.right.nil?
      temp2 = node.left
      temp = minValueNode(node.right)
      node.data = temp.data
      node.right = temp.right
      node.left = temp2
    end
  end

  def minValueNode(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(value, node = @root)
    if value == node.data
      node
    elsif value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order(node = @root, queue = [], result = [], &block)    

    return if node.nil?
    result << node.data
       
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    until queue.empty?
        level_order(queue.shift, queue, result)
    end
    p result unless block_given? 
    
  end

=begin
  if block_given?
    yield(result)
  else
    result
  end
  p queue
  p result
  queue << node.left unless node.left.nil?
  result << node.left.data unless node.left.nil?
  queue << node.right unless node.right.nil?
  result << node.right.data unless node.right.nil?
  return result if queue.empty?

  level_order(queue.shift, queue, result, &block)
=end

  def inorder(node = @root, queue = [], &block)
    return if node.nil?
    inorder(node.left, queue)
    queue << node.data
    inorder(node.right, queue)
    queue
    if block_given?
        yield(queue)
      else
        queue
    end
  end

  def preorder(node = @root, queue = [], &block)
    return if node.nil?

    queue << node.data
    preorder(node.left, queue)
    preorder(node.right, queue)
    if block_given?
        yield(queue)
      else
        queue
    end
  end

  def postorder(node = @root, queue = [], &block)
    return if node.nil?

    postorder(node.left, queue)

    postorder(node.right, queue)
    queue << node.data
    if block_given?
        yield(queue)
      else
        queue
    end
  end

  def height(node = @root, height = 0)
    if node.nil?
      height - 1
    else
      left_height = height(node.left, height + 1)
      right_height = height(node.right, height + 1)
      total_height = left_height != right_height ? [left_height, right_height].max : left_height
    end
  end

  def depth(value, _node = @root, _height = 0)
    new_node = find(value)
    height(new_node)
  end

  def balanced?(node = @root)
    if node.nil?
      height - 1
    else
      left_height = height(node.left, height + 1)
      right_height = height(node.right, height + 1)
      (left_height - right_height).abs < 2
    end
  end

  def rebalance(node = @root)    
    self.data = inorder(node)
    self.root = build_tree(data)
  end
end

 array = (Array.new(15) { rand(1..100) })
 new_tree = Tree.new(array) 

if new_tree.balanced? == true
    puts "balanced, your tree is"   
else 
    puts "your tree lacks balance"
end


#puts new_tree.inorder
p new_tree.pretty_print


 p new_tree.inorder
 puts new_tree.level_order
 p new_tree.postorder
 p new_tree.preorder

i = 0
 until i == 10
    new_tree.insert(rand(100..2000))
    i += 1
 end

if new_tree.balanced? == true
    puts "balanced, your tree is"
else 
    puts "your tree lacks balance"
end

new_tree.pretty_print



new_tree.rebalance

if new_tree.balanced? == true
    puts "balanced, your tree is"
else 
    puts "your tree lacks balance"
end

puts new_tree.inorder
p new_tree.postorder
p new_tree.preorder
p new_tree.level_order

p new_tree.pretty_print







