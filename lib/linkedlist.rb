# frozen_string_literal: true

require_relative 'node'

# Class that adds actions in regards to linked lists
class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
      return @head
    end
    new_node = Node.new(value)
    @tail.next_node = new_node

    @tail = new_node
  end

  def prepend(value)
    if @head.nil?
      new_node = Node.new(value)
      @tail = new_node
    else
      new_node = Node.new(value, @head)
    end
    @head = new_node
    new_node
  end

  def size
    node = @head
    count = 1
    until node.next_node.nil?
      node = node.next_node
      count += 1
    end
    count
  end

  def at(index)
    node = @head
    index.times do
      return nil if node.next_node.nil?

      node = node.next_node
    end
    node
  end

  def pop
    node = @head
    second_to_last = nil
    until node == @tail
      second_to_last = node
      node = node.next_node
    end
    @head, @tail = nil if @head == @tail
    @tail = second_to_last
    @tail.next_node = nil
    @head
  end

  def contains?(value)
    return false if @head.nil?

    node = @head
    loop do
      return true if node.value == value
      break if node.next_node.nil?

      node = node.next_node
    end
    false
  end

  def find_by_key(key)
    return nil if @head.nil?

    index = -1
    node = @head
    loop do
      index += 1
      return index if node.value.key == key
      break if node.next_node.nil?

      node = node.next_node
    end
    return false if index == -1

    nil
  end

  def remove_by_key(key)
    return nil if @head.nil?

    index = -1
    node = @head
    previous_node = nil
    loop do
      previous_node = node
      index += 1
      if node.value.key == key
        return case_head_node(node) if node == @head
        return case_last_node(node) if node.next_node.nil?

        previous_node.next_node = node.next_node
        return node
      end

      node = node.next_node
    end
    return false if index == -1

    nil
  end

  def find(value)
    return nil if @head.nil?

    index = -1
    node = @head
    loop do
      index += 1
      return index if node.value == value
      break if node.next_node.nil?

      node = node.next_node
    end
    return false if index == -1

    nil
  end

  def fetch_linked_list_keys
    return nil if @head.nil?

    node = @head
    result = []
    until node.next_node.nil?
      result << node.value.key
      node = node.next_node
    end
    result << node.value.key
    result
  end

  def fetch_linked_list_values
    return nil if @head.nil?

    node = @head
    result = []
    until node.next_node.nil?
      result << node.value.value
      node = node.next_node
    end
    result << node.value.value
    result
  end

  def fetch_linked_list_key_and_values
    return nil if @head.nil?

    node = @head
    result = []
    until node.next_node.nil?
      result << [node.value.key, node.value.value]
      node = node.next_node
    end
    result << node.value.value
    result
  end

  def my_to_s
    return nil if @head.nil?

    node = @head
    result = "( #{if_hash_entry_to_s(node)} ) -> "
    until  node.next_node.nil?
      node = node.next_node
      result += "( #{if_hash_entry_to_s(node)} ) -> "
    end
    "#{result}nil"
  end

  def remove_hash_entry(_entry)
    return nil if @head.nil?

    index = -1
    node = @head
    loop do
      index += 1
      return index if node.value.key == key
      break if node.next_node.nil?

      node = node.next_node
    end
    return false if index == -1

    nil
  end

  private

  def case_head_node(node)
    removed_entry_value = node.value.value
    node = node.next_node
    @head = node
    removed_entry_value
  end

  def case_last_node(node)
    removed_entry_value = node.value.value
    pop
    removed_entry_value
  end

  def if_hash_entry_to_s(node)
    node.value unless node.value.is_a?(HashEntry)
    hash_entry = node.value
    key = hash_entry.key
    value = hash_entry.value
    "[#{key}, #{value}]"
  end

  def get_key(_entry)
    hash_entry = node.value
    key = hash_entry.key
    value = hash_entry.value
    array = []
    array.push(key, value)
    array
  end
end
