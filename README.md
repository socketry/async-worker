# Async::Worker

Provides a thread-pool backed work queue for executing blocking operations in a non-blocking fashion using [async]. **Experimental**

[async]: https://github.com/socketry/async

[![Build Status](https://travis-ci.com/socketry/async-worker.svg)](https://travis-ci.com/socketry/async-worker)
[![Code Climate](https://codeclimate.com/github/socketry/async-worker.svg)](https://codeclimate.com/github/socketry/async-worker)
[![Coverage Status](https://coveralls.io/repos/socketry/async-worker/badge.svg)](https://coveralls.io/r/socketry/async-worker)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'async-worker'
```

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install async-worker

## Usage

Create a pool and execute jobs using it:

```ruby
Async::Reactor.run do |task|
	# Make a pool with two workers:
	pool = Async::Worker::Pool.new(2)
	
	tasks = 5.times.collect do
		task.async do
			# Add the work to the queue and wait for it to complete:
			pool.async do
				sleep 0.1
			end
		end
	end
	
	tasks.each(&:wait)
	
	pool.close
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See Also

- [async-container](https://github.com/socketry/async-container) — A container for parallel execution.

## License

Released under the MIT license.

Copyright, 2017, by [Samuel G. D. Williams](http://www.codeotaku.com/samuel-williams).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTWorkerN OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTWorkerN WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
