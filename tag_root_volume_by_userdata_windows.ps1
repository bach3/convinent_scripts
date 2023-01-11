#Ref:https://aws.amazon.com/jp/premiumsupport/knowledge-center/cloudformation-instance-tag-root-volume/
#Windows UserData with standard Powershell commands (no AWS CLI installed)
    UserData: 
    Fn::Base64: !Sub |
      <powershell>
      try {  
      $AWS_AVAIL_ZONE=(Invoke-WebRequest -Uri 'http://169.254.169.254/latest/meta-data/placement/availability-zone' -UseBasicParsing).Content
      $AWS_REGION=$AWS_AVAIL_ZONE.Substring(0,$AWS_AVAIL_ZONE.length-1)
      $AWS_INSTANCE_ID=(Invoke-WebRequest -Uri 'http://169.254.169.254/latest/meta-data/instance-id' -UseBasicParsing).Content
      $ROOT_VOLUME_IDS=((Get-EC2Instance -Region $AWS_REGION -InstanceId $AWS_INSTANCE_ID).Instances.BlockDeviceMappings | where-object DeviceName -match '/dev/sda1').Ebs.VolumeId
      $tag = New-Object Amazon.EC2.Model.Tag
      $tag.key = "MyRootTag"
      $tag.value = "MyRootVolumesValue"
      New-EC2Tag -Resource $ROOT_VOLUME_IDS -Region $AWS_REGION -Tag $tag
      }
      catch {
      Write-Output $PSItem
      }
      </powershell>
