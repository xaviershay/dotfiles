require 'spec'

describe 'format_cucumber_table' do
  it 'aligns all columns to be the same width' do
    @input = <<-EOS
| a | abc |
| ab | ab |
| c | a |
    EOS
    @expected = <<-EOS
| a  | abc |
| ab | ab  |
| c  | a   |
    EOS
  end

  it 'preserves indenting from the indent of the first line' do
    @input = <<-EOS
  | a |
| a |
   | a |
    EOS
    @expected = <<-EOS
  | a |
  | a |
  | a |
    EOS
  end

  after do
    output = nil
    IO.popen("format_cucumber_table.rb", "w+") do |f|
      f.write @input
      f.close_write
      output = f.read
    end
    output.should == @expected
  end
end
