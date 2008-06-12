require 'yaml'

file_name = VIM::evaluate("expand('%:p')")
highlight_errors = true

VIM::command("match none")
VIM::command("2match none")
VIM::command("highlight StatusLine guifg=black guibg=grey")

if file_name =~ %r{app/models/(.*).rb$}
  expect_file = "expectations/models/#{$1}_expect.rb"
  highlight_errors = false
  file_name = file_name.gsub(%r{app/models/(.*).rb$}, '') + expect_file
end

if File.open(file_name).grep(/^\s*Expectations/).empty?
  print "Not an expectations file"
else
  results = `ruby_fork_client -r '#{file_name}'`
  y = YAML.load(results)
  VIM::command("highlight TestError     guibg=Brown")
  VIM::command("highlight TestException guibg=DarkRed")
  i = nil
  if highlight_errors
    {
      :failures  => 'TestError',
      :errors    => 'TestException',
      :successes => ''
    }.each_pair do |type, matchClass|
      if (y[type] || []).empty?
        VIM::command("#{i}match none")
      else
        y[type].each do |result|
          b = VIM::Buffer.current
          line = b[result[:line]]
          line.gsub!(/ # =>.*$/, '')
          new_line = line + (result[:message] ? " # => #{result[:message]}" : '') 
          b[result[:line]] = new_line unless b[result[:line]] == new_line
        end
        fail_lines = y[type].collect {|line| "\\%#{line[:line]}l" }.join('\|')
        unless matchClass.empty?
          VIM::command("#{i}match #{matchClass} /#{fail_lines}/")
          i = 2
        end
      end
    end
  end
  VIM::set_option(("statusline=%<%f\ %h%m%r%=" + "%i Succeeded, %i Failed, %i Errored (%.3fs)" % ([:successes, :failures, :errors].collect {|type| y[type].length} << y[:run_time])).gsub(' ', '\ '))
  unless (y[:failures] + y[:errors]).empty?
    VIM::command("highlight StatusLine guibg=Brown")
  end
end
