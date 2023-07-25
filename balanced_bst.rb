class Node
    include comparable

    attr_accessor :data, :left, :right

    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end

    def <=>(other)
        @data <=> other.data
    end
end

class Tree
    attr_accessor :root

    def initialize(arr)
        @root = build_tree(arr)
    end

    def build_tree(arr)
        sorted_arr = arr.uniq.sort

        @root = build_tree_helper(sorted_arr, 0, sorted_arr.length - 1)
    end

    private 

    def build_tree_helper(arr, start_index, end_index)
        return nil if start_index > end_index

        mid_index = (start_index + end_index) / 2

        new_node = Node.new(arr[mid_index]) # Create a new node with the middle element as data

        new_node.left = build_tree_helper(arr, start_index, mid_index - 1)
        new_node.right = build_tree_helper(arr, mid_index + 1, end_index)

        new_node
    end

    public

    def elegant_print(node = @root, prefix = '', is_left = true)
        return if node.nil?

        elegant_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        elegant_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def insert(value)
        @root = insert_node(@root, value)
    end

    def delete(value)
        @root = delete_node(@root, value)
    end
end