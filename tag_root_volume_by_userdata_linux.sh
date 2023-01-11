#REF: https://aws.amazon.com/jp/premiumsupport/knowledge-center/cloudformation-instance-tag-root-volume/
#Linux UserData
  UserData:
     Fn::Base64: !Sub |
      #!/bin/bash
      AWS_AVAIL_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
      AWS_REGION="`echo \"$AWS_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
      AWS_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
      ROOT_VOLUME_IDS=$(aws ec2 describe-instances --region $AWS_REGION --instance-id $AWS_INSTANCE_ID --output text --query Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.VolumeId)
      aws ec2 create-tags --resources $ROOT_VOLUME_IDS --region $AWS_REGION --tags Key=MyRootTag,Value=MyRootVolumesValue
