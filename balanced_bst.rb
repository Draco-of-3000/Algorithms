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