# frozen_string_literal: true

require_relative 'linkedlist'
require_relative 'hashentry'
# Class that defines the behaviors of the Hash Maps
class HashMap
  def initialize
    @load_factor = 0.8
    @capacity = 16
    @buckets = nil
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  def set(key, value)
    bucket_index = get_bucket_index(key)
    raise IndexError if !@buckets.nil? && (bucket_index.negative? || bucket_index >= @buckets.length)

    @buckets = Array.new(@capacity) if @buckets.nil?
    if @buckets[bucket_index].nil?
      @buckets[bucket_index] = HashEntry.new(key, value)
    else
      add_linked_list(bucket_index, key, value)
    end
  end

  def get(key)
    bucket_index = get_bucket_index(key)
    raise IndexError if bucket_index.negative? || bucket_index >= @buckets.length

    if @buckets[bucket_index].nil?
      nil
    else
      desired_hash_entry = get_desired_hash_entry(bucket_index, key)
      return desired_hash_entry unless desired_hash_entry.nil?

      @buckets[bucket_index]
    end
  end

  def has?(key)
    bucket_index = get_bucket_index(key)
    raise IndexError if bucket_index.negative? || bucket_index >= @buckets.length

    # p 'STARTING HAS'
    # @buckets[bucket_index]
    desired_hash_entry = get_desired_hash_entry(bucket_index, key)
    unless desired_hash_entry.nil?
      desired_key = desired_hash_entry.key
      return desired_key == key
    end
    false
  end

  def remove(key)
    if has?(key)
      bucket_index = get_bucket_index(key)
      raise IndexError if bucket_index.negative? || bucket_index >= @buckets.length

      desired_hash_entry = get_desired_hash_entry(bucket_index, key)
      return remove_hash_from_bucket(bucket_index) if desired_hash_entry.nil?

      value = @buckets[bucket_index].remove_by_key(key)
      return value
    end
    nil
  end

  def print_entries
    return print_empty if @buckets.nil?

    @buckets.each do |bucket|
      if bucket.nil?
        print '[]'
      elsif bucket.is_a?(HashEntry)
        print bucket.hash_entry_to_s
      elsif bucket.is_a?(LinkedList)
        print "[#{bucket.my_to_s}]"
      else
        print " #{bucket} "
      end
    end
    puts nil
  end

  def length
    count = 0
    @buckets.each do |bucket|
      next if bucket.nil?

      p 'i am working'
      if bucket.is_a?(HashEntry)
        count += 1
        next
      end
      count += bucket.size
    end
    count
  end

  def clear
    @capacity.times do |index|
      @buckets[index] = nil
      index + 1
    end
  end

  private

  def remove_hash_from_bucket(bucket_index)
    value = @buckets[bucket_index].value
    @buckets[bucket_index] = nil
    value
  end

  def get_bucket_index(key)
    hash(key) % @capacity
  end

  def print_empty
    @capacity.times do
      print []
    end
    puts nil
    nil
  end

  def get_desired_hash_entry(bucket_index, key)
    if !@buckets[bucket_index].nil? && @buckets[bucket_index].is_a?(LinkedList)
      linked_list = @buckets[bucket_index]
      unless linked_list.find_by_key(key).nil?
        desired_node = linked_list.at(linked_list.find_by_key(key))
        desired_hash_entry = desired_node.value
        return desired_hash_entry
      end
    end
    nil
  end

  def add_linked_list(bucket_index, key, value)
    if @buckets[bucket_index].is_a?(HashEntry)
      list_in_bucket = LinkedList.new
      list_in_bucket.prepend(@buckets[bucket_index])
      list_in_bucket.append(HashEntry.new(key, value))
      @buckets[bucket_index] = list_in_bucket
    else
      @buckets[bucket_index].prepend(HashEntry.new(key, value))
    end
    @buckets[bucket_index]
  end
  # raise IndexError if index.negative? || index >= @buckets.length
end
