module Enumerable
## my_each and my_each_with_index are only included here for learning and convenience purposes as I attempted to gain a "Floor to Ceiling" appreciation for what happens with Enumerable  
  def my_each
    n = self.length
    i = 0
    while i < n
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
  	n = self.length
  	i = 0
  	while i < n
  	  yield(self[i],i)
  	  i += 1
  	end
  	self
  end

  def my_select
    arr = []
      self.my_each do |x|
      	arr.push(x) if yield(x) 
      end
      arr
  end

  def my_all?
    result = true
	self.my_each do |x|
	  result = false unless yield(x) 
	end
	result
  end

  def my_any?
  	result = false
  	self.my_each do |x|
  	  result = true if yield(x) 
  	end
  	  result
  end

  def my_none?
  	result = true
  	self.my_each do |x|
  	  result = false if yield(x) 
  	  end
  	  result
  end

  def my_count
  	count = 0
  	self.my_each do |x|
  	  count += 1 if yield(x) 
  	  end
  	  count
  end

  def my_map
  	arr = []
  	self.my_each do |x|
  	  arr.push yield(x)
  	end
  	arr
  end

  def my_inject(initial = nil, sym = nil)
	# This still seems to be a mess, but less of a mess than before
	case 
	when initial.is_a?(Symbol)
	  sym = initial
	  memo = self[0]
	  self[1..-1].my_each do |x|
	    memo = memo.send(sym, x)
	  end
	  memo
	when initial && sym
	  memo = initial
	  self.my_each do |x|
	    memo = memo.send(sym,x)
	  end
	  memo
	when initial && block_given?
	  memo = initial
	  self.my_each do |x|
	    memo = yield(memo,x)
	  end
	  memo
	when block_given?
	  memo = self[0]
	  self[1..-1].my_each do |x|
	  	memo = yield(memo,x)
	  end
	  memo
	end
  end
end

def test_my_methods
  test = [1,2,3,4]
  puts "TESTING my_each"
  test.my_each do |x|
    puts "#{x}"
  end

  puts "TESTING my_each_with_index"
    test.my_each_with_index do |x, index|
      puts "#{x},#{index}"
    end
  
  puts "TESTING my_select"
  puts test.my_select {|x| x % 2 == 0}.to_s
  puts test.select {|x| x % 2 == 0}.to_s
  puts "TESTING my_none?"
  puts test.my_none? {|x| x > 4}.to_s
  puts test.none? {|x| x > 4}.to_s
  puts "TESTING my_count"
  puts test.my_count {|x| x < 5}
  puts test.count {|x| x < 5}
  puts "TESTING my_map"
  puts test.my_map {|x| x = 0}.to_s
  puts test.map {|x| x = 0}.to_s
  puts "TESTING my_all?"
  puts test.my_all? {|x| x > 0}
  puts test.all? {|x| x > 0}
  puts "TESTING my_any?"
  puts test.my_any? {|x| x == 1}
  puts test.any? {|x| x == 1}
  puts "TESTING my_inject"
  puts "... with :+"
  puts test.my_inject(:+)
  puts test.inject(:+)
  puts test.my_inject(100,:+)
  puts test.inject(100,:+)
  puts "... with block"
  puts test.my_inject {|memo, x| memo + x}
  puts test.inject {|memo, x| memo + x}
  puts "... with block and (100)"
  puts test.my_inject(100) {|memo, x| memo + x}
  puts test.inject(100) {|memo, x| memo + x}
end

test_my_methods


