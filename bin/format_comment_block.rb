#!/usr/bin/env ruby

# Formats a ruby comment block to be block justified to a max width. Just
# like this text here.
#
# From github.com/xaviershay/dotfiles

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
