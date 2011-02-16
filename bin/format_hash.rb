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

OPERATOR_RE = /:(?=\s)|=>|=/

lines    = readlines
operator = nil
indent   = lines.first.index(/[^\s]/)

# Massage into an array of [key, value]
lines.collect! do |line|
  if line =~ OPERATOR_RE
    operator ||= $&
    line.partition(operator).map(&:strip)
  end
end

max_key_length = lines.map {|line| line[0].length}.max

# Pad each key with whitespace to match length of longest key
lines.map! do |line|
  if operator =~ /:/
    line[0] = "%#{indent}s%-#{max_key_length+2}s" % ["", line[0] + ': ']
    line[0] + line[2]
  else
    line[0] = "%#{indent}s%-#{max_key_length}s" % ["", line[0]]
    line[0] + " #{operator} " + line[2]
  end
end

print lines.join("\n")
