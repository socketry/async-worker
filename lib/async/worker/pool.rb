# Copyright, 2018, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'async/reactor'
require 'thread'

require_relative 'notification'

module Async
	module Worker
		class Pool
			def initialize(workers = 4)
				@threads = []
				
				@queue = Thread::Queue.new
				
				workers.times {create_worker}
			end
			
			def close
				@queue.close
				@threads.each(&:join)
			end
			
			def async(&block)
				notification = Notification.new
				
				result = nil
				
				job = lambda do
					begin
						result = block.call
					rescue Exception
						result = $!
					ensure
						notification.signal
					end
				end
				
				@queue << job
				
				notification.wait
				notification.close
				
				return result
			end
			
			private
			
			def create_worker
				thread = Thread.new do
					while job = @queue.pop
						job.call
					end
				end
				
				@threads << thread
			end
		end
	end
end
