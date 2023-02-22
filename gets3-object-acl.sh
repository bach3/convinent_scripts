#!/bin/bash

my_buckets=$(aws s3 ls | awk '{print $3}')
#my_buckets=$(cat bucketlists.txt | awk '{print $1}')

for bucket in $my_buckets; do
    for key in $(aws s3 ls --recursive s3://$bucket/ | awk '{print $4}'); do
        object_acl=$(aws s3api get-object-acl --bucket $bucket --key $key)
        result_found=$(echo $object_acl | grep "AllUsers")
        if [ ! -z "$result_found" ] ; then
            echo $bucket
            echo $key;
            echo $object_acl;
        fi;
        done
    done