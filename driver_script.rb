require_relative 'balanced_bst'

# Create a binary search tree from an array of random numbers
random_array = Array.new(15) { rand(1..100) }
tree = Tree.new(random_array)

tree.elegant_print

# Confirm that the tree is balanced
puts "Your Binary Search Tree is #{tree.balanced? ? 'balanced' : 'not balanced'}."

# Print out all elements in level, pre, post, and in order
puts "Level order traversal:"
tree.level_order { |node| print "#{node.data} " }
puts "\nPreorder traversal:"
tree.preorder { |node| print "#{node.data} " }
puts "\nInorder traversal:"
tree.inorder { |node| print "#{node.data} " }
puts "\nPostorder traversal:"
tree.postorder { |node| print "#{node.data} " }

# Unbalance the tree by adding several numbers > 100
5.times do
    a = rand(100..150)
    tree.insert(a)
    puts "Inserted #{a} to tree."
end

# Confirm that the tree is unbalanced
puts "\nYour Binary Search Tree is #{tree.balanced? ? 'balanced' : 'not balanced'}."
puts "Rebalancing tree..."

# Balance the tree by calling #rebalance
tree.rebalance

tree.elegant_print

# Confirm that the tree is balanced after rebalancing
puts "Your Binary Search Tree is #{tree.balanced? ? 'balanced' : 'not balanced'}."

# Print out all elements in level, pre, post, and in order after rebalancing
puts "Level order traversal:"
tree.level_order { |node| print "#{node.data} " }
puts "\nPreorder traversal:"
tree.preorder { |node| print "#{node.data} " }
puts "\nInorder traversal:"
tree.inorder { |node| print "#{node.data} " }
puts "\nPostorder traversal:"
tree.postorder { |node| print "#{node.data} " }
