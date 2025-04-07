##########################

#Author : abdul azees
#Date : 6th - April 2025
#
#Version : V1

#This script will report the AWS resourse Usage

###################################

# These resources will tracked by this script
#
# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM USers

set -x
set -e
set -o


#list s3 buckets
echo "List of S3 Buckets "
aws s3 ls


#list EC2 Instances
echo "List of EC2 Instances "

# to only get instances id

aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

#list AWS Lamda functions
echo "List of AWS Lambda functions "


"aws_resource_tracker.sh" 50L, 652B                                                                                            36,72         18%
