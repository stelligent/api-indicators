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

@gate = Aws::OpsWorks.new region: 'us-east-1'
@sleeptime = 10

def print_and_flush(str)
  print str
  STDOUT.flush
end

opts = Trollop::options do
  opt :region, 'The AWS region to use', :type => String, :default => "us-west-2"
  opt :stackid, 'the OpsWorks stack id to destroy', :type => String, :required => true
end


def delete_stack_and_associated_resources stack_id
  print_and_flush "deleting apps..."
  while (does_stack_have_apps? stack_id)
    delete_all_apps_for_stack stack_id
    sleep @sleeptime
    print_and_flush "."
  end
  puts
  print_and_flush "stopping instances..."  
  while (!are_all_instances_stopped_for_stack? stack_id)
    stop_all_instances_for_stack stack_id
    sleep @sleeptime
    print_and_flush "."
  end
  puts
  print_and_flush "deleting instances..."  
  while (does_stack_have_instances? stack_id)
    delete_all_instances_for_stack stack_id
    sleep @sleeptime
    print_and_flush "."
  end
  puts
  print_and_flush "deleting instances..."  
  while(does_stack_have_layers? stack_id)
    delete_all_layers_for_stack stack_id
    sleep @sleeptime
    print_and_flush "."
  end
  
  puts
  puts "deleting stack..."  
  @gate.delete_stack stack_id: stack_id
end 

def does_stack_exist? stackid
  result = true
  begin
    stacks = @gate.describe_stacks({:stack_ids => [stackid]})
  rescue Aws::OpsWorks::Errors::ResourceNotFoundException
    puts "Stack #{stackid} not found!"
    result = false
  end
  result
end

def stop_all_instances_for_stack stack_id
  @gate.describe_stacks({:stack_ids => [stack_id]})[:stacks].each do |stack|
    @gate.describe_instances(stack_id: stack[:stack_id])[:instances].each do |instance|
      if (instance[:status] != "stopped")
        @gate.stop_instance instance_id: instance[:instance_id]
      end
    end
  end
end

def are_all_instances_stopped_for_stack? stack_id
  result = true
  @gate.describe_stacks({:stack_ids => [stack_id]})[:stacks].each do |stack|
    @gate.describe_instances(stack_id: stack[:stack_id])[:instances].each do |instance|
      if (instance[:status] != "stopped")
        result = false
        break
      end
    end
  end
  return result
end

def does_stack_have_instances? stack_id
  result = false
  @gate.describe_stacks({:stack_ids => [stack_id]})[:stacks].each do |stack|
    @gate.describe_instances(stack_id: stack[:stack_id])[:instances].each do |instance|
      result = true
      break
    end
  end
  return result
end

def does_stack_have_apps? stack_id
  result = false
  @gate.describe_stacks({:stack_ids => [stack_id]})[:stacks].each do |stack|
    @gate.describe_apps(stack_id: stack[:stack_id])[:apps].each do |app|
      result = true
      break
    end
  end
  return result
end


def delete_all_apps_for_stack stack_id
  result = []
  @gate.describe_stacks({:stack_ids => [stack_id]})[:stacks].each do |stack|
    @gate.describe_apps(stack_id: stack[:stack_id])[:apps].each do |app|
      result << app
      @gate.delete_app app_id: app[:app_id]
    end
  end
  return result
end

def delete_all_instances_for_stack stack_id
  result = []
  @gate.describe_stacks({:stack_ids => [stack_id]})[:stacks].each do |stack|
    @gate.describe_instances(stack_id: stack[:stack_id])[:instances].each do |instance|

      @gate.delete_instance instance_id: instance[:instance_id]
      result << instance
    end
  end
  return result
end

def delete_all_layers_for_stack stack_id
  result = []
  @gate.describe_stacks({:stack_ids => [stack_id]})[:stacks].each do |stack|
    @gate.describe_layers(stack_id: stack[:stack_id])[:layers].each do |layer|
      @gate.delete_layer layer_id: layer[:layer_id]
      result << layer
    end
  end
  return result
end

def does_stack_have_layers? stack_id
  result = false
  @gate.describe_stacks[:stacks].each do |stack| 
    @gate.describe_layers(stack_id: stack_id)[:layers].each do |layer|
      result = true
      break
    end
  end
  return result        
end    

if does_stack_exist? opts[:stackid]
  delete_stack_and_associated_resources opts[:stackid]
end