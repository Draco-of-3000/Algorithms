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

    private

    def insert_node(node, value)
        return Node.new(value) if node.nil?

        if value < node.data
            node.left = insert_node(node.left, value)
        elsif value > node.data
            node.right = insert_node(node.right, value)
        end

        node
    end

    def delete_node(node, value)
        return node if node.nil?

        if value < node.data
            node.left = delete_node(node.left, value)
        elsif value > node.data
            node.right = delete_node(node.right, value)
        else 
            # If there's no child or one child
            return node.left if node.right.nil?
            return node.right if node.left.nil?

            # If there are two children
            min_right_subtree = find_min(node.right)
            node.data = min_right_subtree.data
            node.right = delete_node(node.right, min_right_subtree.data)
        end

        node
    end

    def find_min(node)
        current = node
        current = current.left while current.left
        current
    end

    public

    def find(value)
        return find_node(@root, value)
    end

    private

    def find_node(node, value)
        return nil if node.nil?

        if value == node.data
            return node
        elsif value < node.data
            return find_node(node.left, value)
        else
            return find_node(node.right, value)
        end
    end
end