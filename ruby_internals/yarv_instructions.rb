code = <<-RUBY
puts 2 + 2
RUBY

puts RubyVM::InstructionSequence.compile(code).disasm
