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
end