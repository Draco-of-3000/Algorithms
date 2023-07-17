class Linkedlist
    attr_reader :head

    def initialize
        @head = nil
    end

    def append(value)
        if @head.nil?
            @head = Node.new(value)
        else 
            current_node = @head 
            while current_node.next_node
                current_node = current_node.next_node
            end
            current_node.next_node = Node.new(value)
        end
    end

    def prepend(value)
        new_node = Node.new(value)
        new_node.next_node = @head
        @head = new_node
    end
end