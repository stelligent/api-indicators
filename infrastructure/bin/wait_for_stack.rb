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

opts = Trollop::options do
  opt :region, 'The AWS region to use', :type => String, :default => "us-west-2"
  opt :stackid, 'the OpsWorks stack id to monitor', :type => String, :required => true
end

def wait_on_all_configures(stack_id)
  opsworks_client = AWS::OpsWorks::Client::V20130218.new
  response = opsworks_client.describe_instances(:stack_id => stack_id)
  response[:instances].each do |instance|
    wait_on_configure(instance[:instance_id])
  end
end

def wait_on_configure(instance_id)
  opsworks_client = AWS::OpsWorks::Client::V20130218.new

  max_attempts = 250
  num_attempts = 0

  while true
    response = opsworks_client.describe_commands(:instance_id => instance_id)
    configure_command = response[:commands].find { |command| command[:type] == 'configure' }

    configure_status(configure_command)

    unless configure_command.nil?
      if configure_command[:status] == 'successful'
        return
      elsif configure_command[:status] == 'failed'
        raise 'configure failed'
      end
    end
    num_attempts += 1
    if num_attempts >= max_attempts
      raise 'stuck waiting on configure command max attempts'
    end
    sleep 10
  end
end

def configure_status(configure_command)
    puts "Configure command: #{configure_command}"
end

wait_on_all_configures opts[:stackid]
