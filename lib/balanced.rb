require 'pry-byebug'

class Node

    attr_accessor :data, :left, :right
    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end

    def Comparable(next_node)
        self.data == next_node.data ? true : false 
    end
end


class Tree
    attr_accessor :root
    def initialize(array)
        arr = array.sort.uniq
        @root = build_tree(arr)
    end

    def build_tree(arr)
        return nil if arr.empty?
        mid = (arr.size - 1) / 2
        root_node = Node.new(arr[mid])
        root_node.left = build_tree(arr[0...mid])        
        root_node.right = build_tree(arr[mid+1..-1])      
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
        p node.data
        if value < node.data
            node.left.left.nil? ? node.left = node.left.right : delete(value, node.left)
        elsif value > node.data
            node.right.right.nil? ? node.right = node.right.left : delete(value, node.right)
        else
            if !node.left.nil? && !node.right.nil?
                temp2 = node.left
                temp = minValueNode(node.right)
                node.data = temp.data
                node.right = temp.right
                node.left = temp2            
            end        
        end  
        
    end

    def minValueNode(node)
        current = node
        while current.left != nil
            current = current.left
        end
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

    def level_order(node = @root, queue = [], &block)
        if block_given?            
            yield(node.data)
        else 
            print "#{node.data}"
        end
        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?
        return if queue.empty?
        level_order(queue.shift, queue, &block)       
    end

    def inorder(node = @root, queue = [], &block)
        return if node.nil?     
        inorder(node.left)
        print node.data
        inorder(node.right)
    end

    def preorder(node = @root)
        return if node.nil?     

        print node.data
        preorder(node.left)
        preorder(node.right)
    end

    def postorder(node = @root)
        return if node.nil?
        postorder(node.left)     

        postorder(node.right)
        print node.data
    end

    def height(node = @root, height = 0)
        if node.nil?
            return height-1  
        else
            left_height = height(node.left, height+1)
            right_height = height(node.right, height+1)
            return total_height = left_height != right_height ? [left_height, right_height].max : left_height      
        end
    end

    def depth(value, node = @root, height = 0)
        new_node = find(value)
        height(new_node)
    end
    def balanced?(node = @root)
        if node.nil?
            return height-1  
        else
            left_height = height(node.left, height+1)
            right_height = height(node.right, height+1)
            (left_height - right_height).abs < 2 ? true : false   
        end
    end

end



k = Tree.new([1,2,3,5,6,7,8])
#p k.height
p k.balanced?



k.insert(9)

p k.balanced?

k.insert(19)
p k.balanced?


#p "height is #{k.height}"
#p k.depth(3)
#p k.depth(7)    
#p k.depth(8)


k.pretty_print

#k.level_order do |value|
    #puts "this is #{value}"
#end

#p k.level_order

#p k.inorder

#p k.preorder

#p k.postorder






#k.delete(1)
#k.delete(6)

#k.pretty_print


j = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].sort)

p j.balanced?

p j.pretty_print
#p j.inorder


j.insert(89)

j.insert(213)

p j.pretty_print
    

#p j.balanced?


 #j.insert(893123)

 #j.insert(819)
 #p j.pretty_print









#j = Tree.new([1])

