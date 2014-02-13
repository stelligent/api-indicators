#!/bin/bash -e

pushd infrastructure
ruby bin/create_canary_stack.rb 
ruby bin/wait_for_stack.rb --stackid `cat ops_stackid`
popd