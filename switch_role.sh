
unset AWS_STS
unset AWS_ACCESS_KEY_ID
unset AWS_SESSION_TOKEN
unset AWS_SESSION_EXPIRATION
unset AWS_SECURITY_TOKEN
unset AWS_SECRET_ACCESS_KEY
unset AWS_USERNAME

source ./secrets/aws-credentials.sh

export AWS_ROLE=$1

MFA_VALUE=$2

if [ -n "$OATHSEED" ]; then
  MFA_VALUE="$(oathtool -b --totp $OATHSEED)"
fi


AWS_STS=($(aws sts assume-role --role-arn $ROOT_ARN:role/$AWS_ROLE --serial-number $ROOT_ARN:mfa/$AWS_USERNAME --query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken,Credentials.Expiration]' --output text --token-code $MFA_VALUE --role-session-name $AWS_ROLE))

export AWS_ACCESS_KEY_ID=${AWS_STS[0]}
export AWS_SECRET_ACCESS_KEY=${AWS_STS[1]}
export AWS_SESSION_TOKEN=${AWS_STS[2]}
export AWS_SESSION_EXPIRATION=${AWS_STS[3]}

alias who_aws_ami="aws sts get-caller-identity"

who_aws_ami