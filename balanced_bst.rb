class Node
    include Comparable

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

    public

    def level_order(&block)
        return enum_for(:level_order) unless block_given?

        queue = [@root]
        while !queue.empty?
            current_node = queue.shift
            block.call(current_node)
            queue << current_node.left if current_node.left
            queue << current_node.right if current_node.right
        end
    end

    def inorder(&block)
        return enum_for(:inorder) unless block_given?

        inorder_recursive(@root, &block)
    end

    def preorder(&block)
        return enum_for(:preorder) unless block_given?

        preorder_recursive(@root, &block)
    end

    def postorder(&block)
        return enum_for(:postorder) unless block_given?

        postorder_recursive(@root, &block)
    end
    
    private

    def inorder_recursive(node, &block)
        return if node.nil?

        inorder_recursive(node.left, &block)
        block.call(node)
        inorder_recursive(node.right, &block)
    end

    def preorder_recursive(node, &block)
        return if node.nil?

        block.call(node)
        preorder_recursive(node.left, &block)
        preorder_recursive(node.right, &block)
    end

    def postorder_recursive(node, &block)
        return if node.nil?

        postorder_recursive(node.left, &block)
        postorder_recursive(node.right, &block)
        block.call(node)
    end

    public 

    def height(node = @root)
        return -1 if node.nil?

        left_height = height(node.left)
        right_height = height(node.right)

        # Return the maximum height between left and right subtrees, plus 1 for the current node itself.
        return 1 + [left_height, right_height].max
    end

    def depth(node)
        return -1 if node.nil?

        parent_depth = depth(node.parent)

        return parent_depth + 1
    end

    def balanced?
        return true if @root.nil?

        balanced_recursive?(@root)
    end

    private

    def balanced_recursive?(node)
        return true if node.nil?

        left_height = height(node.left)
        right_height = height(node.right)

        if (left_height - right_height).abs <= 1 && balanced_recursive?(node.left) && balanced_recursive?(node.right)
            return true
        end

        return false
    end

    public 

    def rebalance
        # Perform an inorder traversal to extract node values
        inorder_values = []
        inorder { |node| inorder_values << node.data}

        # Construct a new balanced binary search tree using the inorder values
        @root = build_tree(inorder_values)
    end
end