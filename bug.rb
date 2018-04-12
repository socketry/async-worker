#!/usr/bin/env ruby

require 'thread'

puts RUBY_VERSION

100.times.collect do
	Thread.new do
		mutex = Mutex.new
		input, output = IO.pipe
		
		worker = Thread.new do
			sleep(0.1)
			# mutex.synchronize do
				output.syswrite('.')
			# end
		end
		
		input.read(1)
		
		# mutex.synchronize do
			input.close
			output.close
		# end
		worker.join
	end
end.each(&:join)
