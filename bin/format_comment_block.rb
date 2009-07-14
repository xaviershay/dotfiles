#!/usr/bin/env ruby
lines = []
while line = gets
  lines << line
end

indent = lines.first.index(/[^\s]/)

# Extract words
words = lines.collect do |line|
  line.split(/\s+/)
end.flatten.reject {|x| x.empty? || x == "#" }

words.reverse!
output = ''
indent = "%#{indent}s" % ['']
newline = indent + '#'
while !words.empty?
  newline << ' ' + words.pop
  if newline.length > 70
    output << newline + "\n"
    newline = indent + '#'
  end
end
output << newline unless newline == indent + '#'

puts output
