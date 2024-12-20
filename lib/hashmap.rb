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
    bucket_index = hash(key) % @capacity
    raise IndexError if !@buckets.nil? && (bucket_index.negative? || bucket_index >= @buckets.length)

    @buckets = Array.new(@capacity) if @buckets.nil?
    if @buckets[bucket_index].nil?
      @buckets[bucket_index] = HashEntry.new(key, value)
    else
      add_linked_list(bucket_index, key, value)
    end
  end

  def get(key)
    bucket_index = hash(key) % @capacity
    raise IndexError if bucket_index.negative? || bucket_index >= @buckets.length

    if @buckets[bucket_index].nil?
      nil
    else
      @buckets[bucket_index][@buckets[bucket_index].find(key)] if @buckets[bucket_index].is_a?(LinkedList)
      @buckets[bucket_index]
    end
  end

  def has?(key)
    
  end

  private

  def add_linked_list(bucket_index, key, value)
    if @buckets[bucket_index].is_a?(HashEntry)
      @buckets[bucket_index] = LinkedList.new.append(HashEntry.new(key, value))
    else
      @buckets[bucket_index].append(HashEntry.new(key, value))
    end
    @buckets[bucket_index]
  end
  # raise IndexError if index.negative? || index >= @buckets.length
end
