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

  def to_s
    return nil if @head.nil?

    node = @head
    result = ''
    until  node.next_node.nil?
      result += "( #{node.value} ) -> "
      node = node.next_node
    end
    "#{result}nil"
  end
end
