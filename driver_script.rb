require_relative 'balanced_bst'

# Create a binary search tree from an array of random numbers
random_array = Array.new(15) { rand(1..100) }
tree = Tree.new(random_array)

# Confirm that the tree is balanced
puts "Tree is balanced? #{tree.balanced?}"  # Should print 'true' if balanced

# Print out all elements in level, pre, post, and in order
puts "Level order: #{tree.level_order.to_a}"
puts "Preorder: #{tree.preorder.to_a}"
puts "Postorder: #{tree.postorder.to_a}"
puts "Inorder: #{tree.inorder.to_a}"

# Unbalance the tree by adding several numbers > 100
tree.insert(150)
tree.insert(200)
tree.insert(250)

# Confirm that the tree is unbalanced
puts "Tree is balanced? #{tree.balanced?}"  # Should print 'false' if unbalanced

# Balance the tree by calling #rebalance
tree.rebalance

# Confirm that the tree is balanced after rebalancing
puts "Tree is balanced? #{tree.balanced?}"  # Should print 'true' if balanced

# Print out all elements in level, pre, post, and in order after rebalancing
puts "Level order (after rebalancing): #{tree.level_order.to_a}"
puts "Preorder (after rebalancing): #{tree.preorder.to_a}"
puts "Postorder (after rebalancing): #{tree.postorder.to_a}"
puts "Inorder (after rebalancing): #{tree.inorder.to_a}"