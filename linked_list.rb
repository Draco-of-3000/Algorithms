class Node
    attr_accessor :value, :next_node
  
    def initialize(value)
      @value = value
      @next_node = nil
    end
end
  
class Linkedlist
    attr_reader :head, :tail

    def initialize
        @head = nil
        @tail = nil
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

    def size
        count = 0
        current_node = @head
        while current_node
            count += 1
            current_node = current_node.next_node
        end
        count
    end

    def head
        @head
    end

    def tail_node
        return nil if @head.nil?

        current_node = @head
        while current_node.next_node
            current_node = current_node.next_node
        end
        @tail = current_node
    end

    def at(index)
        return nil if index < 0 || index >= size 

        current_node = @head 
        count = 0
        while count < index 
            current_node = current_node.next_node
            count += 1
        end
        current_node
    end

    def pop
        return nil if @head.nil?

        popped_node = tail_node
    end

    def contains?(value)
        current_node = @head

        while current_node
            return true if current_node.value == value
            current_node = current_node.next_node
        end
        false
    end

    def find(value)
        current_node = @head
        index = 0

        while current_node
            return index if current_node.value == value
            current_node = current_node.next_node
            index += 1
        end
        nil
    end

    def to_s
        current_node = @head
        result = ""

        while current_node
            result += "( #{current_node.value} ) -> "
            current_node = current_node.next_node
        end
        result += "nil"
        result
    end
end