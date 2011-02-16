require 'rspec'

describe 'format_hash' do
  it 'aligns all => signs' do
    @input = <<-EOS
      :a => 1
      :ab => 2
    EOS
    @expected = <<-EOS
      :a  => 1
      :ab => 2
    EOS
  end

  it 'aligns all = signs' do
    @input = <<-EOS
      a  = 1
      ab = 2
    EOS
    @expected = <<-EOS
      a  = 1
      ab = 2
    EOS
  end

  it 'aligns all : signs' do
    @input = <<-EOS
      a: 1
      b:   1
      ab: 2
    EOS
    @expected = <<-EOS
      a:  1
      b:  1
      ab: 2
    EOS
  end

  it 'does not strip extra =>' do
    @input    = "a => 1 # COMMENT:=>yeah"
    @expected = "a => 1 # COMMENT:=>yeah"
  end

  it 'does not strip extra :' do
    @input    = "a: 1 # COMMENT: yeah"
    @expected = "a: 1 # COMMENT: yeah"
  end

  after do
    output = nil
    IO.popen("format_hash.rb", "w+") do |f|
      f.write @input
      f.close_write
      output = f.read
    end
    output.should == @expected.chomp
  end
end
