# frozen_string_literal: true

require_relative 'lib/hashmap'

map = HashMap.new

# Set some key-value pairs
map.print_entries
map.set('name', 'Carlos')
map.print_entries
map.set('age', 22)
map.print_entries
map.set('city', 'Madrid')
map.print_entries

# Get values for the keys
map.get('name')
map.get('age')
map.get('city')

# Try to get a non-existent key (should return nil)
map.get('country')

# Set more keys to test collision handling
map.set('new_name', 'Carlos Jr.')
map.set('new_age', 23)

# Test getting values for newly added keys
map.get('new_name')
map.get('new_age')

# Test collision: Both 'name' and 'new_name' might be in the same bucket
map.get('name')
map.get('new_name')

# Test a non-existent key after several operations
map.get('random_key')

# Checking if the map contains certain keys (example placeholder)
p map.has?('name')
p map.has?('random_key')

# Check the current state of the map (printing the HashMap)
# map.print_entries

# Add more values to test size and operations
map.set('country', 'Spain')
map.set('language', 'Spanish')

# Retrieve the updated map as a string
# map.print_entries
