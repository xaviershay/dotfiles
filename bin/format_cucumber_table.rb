#!/usr/bin/env ruby
indent = nil
lines = []
while line = gets
  indent ||= line.index(/[^\s]/)
  lines << line.split(/\s*\|\s*/)[1..-1]
end

cols = lines.first.size
max_widths = (0..cols-1).collect do |column_index|
  lines.collect {|line| line[column_index].size }.max
end

class Array
  def collect_with_index
    i = 0
    self.collect do |x|
      result = yield(x, i)
      i += 1
      result
    end
  end
end

lines.collect! do |line|
  line.collect_with_index do |column, index|
    "%-#{max_widths[index]}s" % [column]
  end
end

indent = "%#{indent}s" % ['']
lines.collect! do |line|
  indent + "| " + line.join(" | ") + " |"
end

puts lines
