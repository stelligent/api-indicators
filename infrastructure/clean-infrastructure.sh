#!/bin/bash -e

pushd infrastructure
ruby bin/destroy_opsworks_stack.rb --stackid `cat ops_stackid`
ruby bin/destroy_cloudformation_stack.rb --stackname `cat cfn_stackname`
popd