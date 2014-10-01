=begin
  Maintainer: Ben Douglas
=end

$maxstack = 0

#Recursive method to return number of times a number can be divided by 2
def div_2(val, c=0)
  $maxstack = $maxstack < caller.size ? caller.size : $maxstack
  val > 2 ? div_2(val/2,c+1) :  c
end

input = 2 ** 20000
puts "Let's see how many times:\n#{input}\nCan be divided by two, recursively!"
begin
  div_2 input
rescue SystemStackError
  puts "Stack overflow at: #{$maxstack}"
end

