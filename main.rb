# frozen_string_literal: true

require_relative 'lib/hashmap'

map = HashMap.new

map.print_entries
map.set('name', 'Carlos')
map.print_entries
map.set('age', 22)
map.print_entries
map.set('city', 'Madrid')
map.set('building', 'house')
map.set('kitchen', 'modern')
map.set('bathroom', 'need of repairs')
map.print_entries

map.get('name')
map.get('age')
map.get('city')

map.get('country')

map.set('new_name', 'Carlos Jr.')
map.set('new_age', 23)

map.get('new_name')
map.get('new_age')

map.get('name')
map.get('new_name')

map.get('random_key')

p map.has?('name')
p map.has?('random_key')

p map.remove('name')

map.print_entries
p map.length

map.set('country', 'Spain')
map.set('language', 'Spanish')

p map.keys
p map.values

map.print_entries
map.clear
map.print_entries
