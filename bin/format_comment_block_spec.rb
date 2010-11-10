require 'rspec'

describe 'format_comment_block' do
  it 'aligns all columns to be the same width' do
    @input = <<-EOS
# Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello
# Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello
    EOS
    @expected = <<-EOS
# Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello
# Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello
# Hello Hello Hello Hello
    EOS
  end

  it 'aligns all columns to be the same width - test 2' do
    @input = <<-EOS
# Lorem ipsum 
# dolor sit amet, consectetur adipiscing elit. 
# Donec ut vehicula felis. Nunc ut libero id metus tristique adipiscing sit amet ac diam. Quisque consequat mollis eros, aliquet adipiscing diam elementum in. Vivamus vel libero
# eget lorem semper faucibus. Aenean pretium sagittis molestie. Quisque magna erat, egestas eget adipiscing vel,
# eleifend
# eu tortor. 
    EOS
    @expected = <<-EOS
# Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut vehicula
# felis. Nunc ut libero id metus tristique adipiscing sit amet ac diam.
# Quisque consequat mollis eros, aliquet adipiscing diam elementum in. Vivamus
# vel libero eget lorem semper faucibus. Aenean pretium sagittis molestie.
# Quisque magna erat, egestas eget adipiscing vel, eleifend eu tortor.
    EOS
  end

  it 'detects // instead of #' do
    @input    = "// Hello\n// Hello"
    @expected = "// Hello Hello\n"
  end

  it 'preserves indent, and counts it towards the max width' do
    @input = <<-EOS
                                                                 # Hello Hello
    EOS
    @expected = <<-EOS
                                                                 # Hello
                                                                 # Hello
    EOS
  end

  after do
    output = nil
    IO.popen("format_comment_block.rb", "w+") do |f|
      f.write @input
      f.close_write
      output = f.read
    end
    output.should == @expected
  end
end
