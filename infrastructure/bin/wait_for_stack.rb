#Copyright (c) 2014 Stelligent Systems LLC
#
#MIT LICENSE
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.

STDOUT.sync = true

require 'opendelivery'
require 'trollop'
require 'aws-sdk-core'

SUCCESS_STATUSES = %w{ online }
PENDING_STATUSES = %w{ booting pending rebooting requested running_setup shutting_down terminating }
FAILURE_STATUSES = %w{ connection_lost setup_failed start_failed stopped terminated }

@opsworks_client = Aws::OpsWorks.new region: "us-east-1"

def all_instances_online? stack_id
  result = true
  response = @opsworks_client.describe_instances(:stack_id => stack_id)
  response[:instances].each do |instance|
    unless SUCCESS_STATUSES.include? instance.status
      result = false
      break
    end 
  end
  result
end

def any_instances_pending? stack_id
  result = false
  response = @opsworks_client.describe_instances(:stack_id => stack_id)
  response[:instances].each do |instance|
    if PENDING_STATUSES.include? instance.status
      result = true
      break
    end 
  end
  result
end

def all_instances_stopped? stack_id
  result = true
  response = @opsworks_client.describe_instances(:stack_id => stack_id)
  response[:instances].each do |instance|
    unless FAILURE_STATUSES.include? instance.status
      result = false
      break
    end 
  end
  result
end

def print_and_flush(str)
  print str
  STDOUT.flush
end


opts = Trollop::options do
  opt :region, 'The AWS region to use', :type => String, :default => "us-west-2"
  opt :stackid, 'the OpsWorks stack id to monitor', :type => String, :required => true
end


print_and_flush "waiting for all instances in stack #{opts[:stackid]} to come up..."
while (any_instances_pending? opts[:stackid])
  sleep 10
  print_and_flush "."
end
puts

exitcode = 0
unless all_instances_online? opts[:stackid]
  puts "Stack failed to launch!"
  exitcode = 1
end

exit exitcode