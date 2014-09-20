=begin
  Maintainer(s)
    Ben Douglas

  Details
    Development Stage : Development
    Ruby version : 1.9.3
    Date last updated : 9/19/2014

  method : simple_gen

      Description
        A simple script to generate a file full of random vectors

      Inputs
        1st : file
          File location for the file to be saved
        2nd : dimension
          Number of dimensions for the generated vectors. 2 could generate your standard x,y plots
        3rd : max
          Maximum value of generated value
        4th : points
          Number of vectors to be generated

      Outputs
        Console
          None
        Return
          None
        Harddisk
          saved file, as specified in first argument

  method : bench_simple_gen

      Description
        Benchmark simple_gen for running time

      Inputs
        1st : iter : optional
          Number of iterations to run during the benchmark

      Outputs
        Console
          Results from benchmark
        Return
          None
        Harddisk
          Temporary file saved, then deleted
=end


def simple_gen(file,dimension,max,points)
  dimension -= 1
  curtime = Time.new
  randseed = Random.new(curtime.usec)
  randval = Random.new(randseed.rand * 1000000) # Just making sure we're extra random

  file = File.open(file,"w")

  #Proc used with .each_with_index
  writeval = Proc.new do |val,index|
    if index < dimension
      file.write("#{val.to_i},")
    else
      file.write("#{val.to_i}")
    end

  end

  points.times do
    vals = []
    for j in 0..dimension do
      vals[j] = max * randval.rand

    end

    vals.each_with_index &writeval

    file.write("\n")
  end
  file.close
end

def bench_simple_gen(iter=100)
  require 'benchmark'
  puts "Simple gen over #{iter} iterations"
  Benchmark.bm do |bm|
    bm.report do
      iter.times do
        simple_gen("testfile.txt",10,1000,100)
      end
    end
  end
  File.delete("testfile.txt")

end

#bench_simple_gen(200)
simple_gen("sample.txt",5,2500,100)






