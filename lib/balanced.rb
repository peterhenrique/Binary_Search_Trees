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
        p node.data
       if value < node.data
        node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)        
       else 
        node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)       
       end 
    end

    def delete(value, node = @root)
        until value == node.data 

        end
    end


end



k = Tree.new([1,2,3,5,6,7,8])

k.insert(9)

p k 



 #p Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

#j = Tree.new([1])

