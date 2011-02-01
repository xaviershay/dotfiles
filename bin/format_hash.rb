#!/usr/bin/env ruby

# Formats ruby hashes and assignments
# a => 1
# ab => 2
# abc => 3
#
# becomes
# a   => 1
# ab  => 2
# abc => 3
#
# a = 1
# ab = 2
# abc = 3
#
# becomes
# a   = 1
# ab  = 2
# abc = 3
#
# a: 1
# ab: 2
# abc: 3
#
# becomes
# a:   1
# ab:  2
# abc: 3
#
# From github.com/xaviershay/dotfiles

OPERATOR_RE = /\:|=>|=/

lines    = readlines
operator = nil
indent   = lines.first.index(/[^\s]/)

# Massage into an array of [key, value]
lines.collect! do |line|
  if line =~ OPERATOR_RE
    operator ||= $&
    line.split(operator).map(&:strip)
  end
end

max_key_length = lines.map {|line| line[0].length}.max

# Pad each key with whitespace to match length of longest key
lines.map! do |line|
  if operator == ':'
    line[0] = "%#{indent}s%-#{max_key_length + 1}s" % ["", line[0] + operator]
    line.join(" ")
  else
    line[0] = "%#{indent}s%-#{max_key_length}s" % ["", line[0]]
    line.join(" #{operator} ")
  end
end

print lines.join("\n")
