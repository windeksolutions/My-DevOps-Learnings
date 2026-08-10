#!/bin/bash


######################################
# Author: Windeksolutions
# date; 6 August 2026
# Devops learning
# v1
#####################################

# this is a an aws resource tracker, tracks:
# EC2 instances
# S3
# Lambda Functions
# Iam Users 

set -e
#set -x
set -o pipefail

# Directory where all reports will be saved
OUTPUT_DIR="$HOME/aws-tracker-reports"
mkdir -p "$OUTPUT_DIR"

# Timestamp for unique filenames (format: ec2_2026-08-06_1430.txt)
TIMESTAMP=$(date +'%Y-%m-%d_%H%M')

echo "========================================"
echo " AWS Resource Tracker Report"
echo "========================================"

# for EC2 instances 
echo"_____ EC2 instances ______"
aws ec2 describe-instances \
	--query 'Reservations[*].Instances[*].[InstanceId,State.Name]'\
	--output table >> "${OUTPUT_DIR}/ec2_${TIMESTAMP}.txt"

# for S3 Buckets
echo "______ S3 Buckets ______"
aws s3 ls >> "${OUTPUT_DIR}/s3_${TIMESTAMP}.txt"

# for Lambda Func
echo "______ aws lambda Funcs_______"
aws lambda list-functions \
	--query 'Functions[*].[FunctionName,Runtime]'\
	--output table >> "${OUTPUT_DIR}/lambda_${TIMESTAMP}.txt"

# for iam users 
echo "_____iam users______"
aws iam list-users \
	--query 'Users[*].[UserName,UserId,CreateDate]'\
	--output table >> "${OUTPUT_DIR}/iam_${TIMESTAMP}.txt"

echo "reports saved in: $OUTPUT_DIR"

