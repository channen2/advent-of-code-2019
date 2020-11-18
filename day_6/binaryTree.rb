module BinaryTree
    class Node
        # include Comparable
        attr_accessor :value, :left_child, :right_child
        def initialize(value)
            @value = value
            @left_child = left_child
            @right_child = right_child
        end

        def <=> (other)
            value <=> other.value
        end

        def to_s
            "{node: #{value}, " +
            "left_child: #{left_child.nil? ? 'nil': left_child.value}, " +
            "right_child: #{right_child.nil? ? 'nil': right_child.value}}"
        end
    end

    class Tree
        attr :root

        def initialize(array)
            @root = build_tree(array.uniq.sort, 0, array.length-1)
        end
            
        def build_tree(array, a, b)
            return nil if a > b
            mid = (a + b) / 2
            root = Node.new(array[mid])
            root.left_child = build_tree(array, a, mid-1)
            root.right_child = build_tree(array, mid+1, b)
            return root 
        end

        def insert_node(value, root=@root)
            return Node.new(value) if root.nil?
            return root if value == root.value

            if value < root.value
                root.left_child = insert_node(value, root.left_child)
            else 
                root.right_child = insert_node(value, root.right_child)
            end
            root
        end

        def insert_to_node(value, root=@root)
            return root if root.nil?
            node = Node.new(value)
            if root.left_child.nil?
                root.left_child = node 
            elsif root.right_child = node
                root.right_child.nil?
            end
        end

        def delete_node(root, value)
            ### base cases:
            return root if root.nil?
            if value < root.value
                root.left_child = delete_node(root.left_child, value)
            elsif value > root.value
                root.right_child = delete_node(root.right_child, value)
            ## node to be deleted
            else
                if root.left_child.nil?
                    return root.right_child
                elsif root.right_child.nil?
                    return root.left_child
                end
                temp = find_min_node(root.right_child)
                root.value = temp.value
                root.right_child = delete_node(root.right_child, temp.value)
            end
            root
        end

        def find_min_node(root)
            return root if root.left_child.nil?
            find_min_node(root.left_child) 
        end

        # Assumes ordered tree
        def find(value, root=@root)
            return root if root.nil?
            if value < root.value
                find(value, root.left_child)
            elsif value > root.value
                find(value, root.right_child)
            else 
                return root
            end
        end

        # BFS to find any node
        def find_plus(value, queue=[@root])
            root = queue.shift
            return root if root.nil? || root.value == value
            queue << root.left_child if root.left_child != nil
            queue << root.right_child if root.right_child != nil
            find_plus(value, queue)
        end

        # breadth first search
        def level_order(queue=[@root], arr=[])
            root = queue.shift
            return arr if root.nil?
            arr << root
            queue << root.left_child if root.left_child != nil
            queue << root.right_child if root.right_child != nil
            level_order(queue, arr)
        end

        # inorder traversal left root right
        def in_order(root=@root, arr=[])
            return root if root.nil?
            in_order(root.left_child, arr)
            arr << root.value
            in_order(root.right_child, arr)
            arr
        end

        # preorder traversal (root left right)
        def pre_order(root=@root, arr=[])
            return root if root.nil?
            arr << root.value
            pre_order(root.left_child, arr)
            pre_order(root.right_child, arr)
            arr
        end

        # postorder traversal (left right root)
        def post_order(root=@root, arr=[])
            return root if root.nil?
            post_order(root.left_child, arr)
            post_order(root.right_child, arr)
            arr << root.value
            arr
        end

        def depth(node, root=@root, i=0)
            return node if node.nil?
            return i if root == node 
            node.value < root.value ? depth(node, root.left_child, i += 1) : depth(node, root.right_child, i += 1)
        end

        def height(node)
            return -1 if node.nil?

            left = height(node.left_child) + 1
            right = height(node.right_child) + 1

            left > right ? left : right
        end

        def balanced?(root=@root)
            return true if root.nil?

            left = height(root.left_child)
            right = height(root.right_child)

            if (left-right).abs < 2
                return balanced?(root.left_child) && balanced?(root.right_child)
            else 
                return false
            end
        end

        def rebalance
            return if balanced?
            values = in_order.uniq
            @root = build_tree(values, 0, values.length-1)
        end

        def pretty_print(node = @root, prefix = '', is_left = true)
            pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
            puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
            pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
        end
    end

    def hi 
        puts "hi"
    end
end


## driver script
# values = Array.new(15){rand(1..100)}
# t = Tree.new(values)
# t.pretty_print
# puts t.balanced?
# puts "In order: #{t.in_order}"
# puts "Pre order: #{t.pre_order}"
# puts "Post order: #{t.post_order}"
# t.insert_node(23)
# t.insert_node(12)
# t.insert_node(17)
# t.insert_node(8)
# puts t.balanced?
# t.rebalance
# t.pretty_print
# puts t.balanced?
# puts "In order: #{t.in_order}"
# puts "Pre order: #{t.pre_order}"
# puts "Post order: #{t.post_order}"
