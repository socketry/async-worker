
require 'benchmark'
require 'async/clock'
require "async/worker"

RSpec.describe Async::Worker do
	include_context Async::RSpec::Reactor
	
	let(:count) {20}
	
	it "can execute work in parallel" do
		task = Async::Task.current
		pool = Async::Worker::Pool.new(count)
		
		tasks = []
		
		duration = Async::Clock.measure do
			count.times do
				tasks << task.async do
					pool.async do
						sleep 0.1
					end
				end
			end
			
			tasks.each(&:wait)
		end
		
		expect(duration).to be_within(0.01).of(0.1)
		pool.close
	end
end
