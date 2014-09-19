# AWS CLI Commands Used

## To create a key pair:

Extract the key from returned response.

```bash
aws ec2 create-key-pair --key-name demoapp_prodkey > demoapp_prodkey.pem
```

Change the permissions:

```bash
chmod 400 demoapp_prodkey.pem
```

To connect to Amazon Linux (user is `ec2-user`) instance which has the IP of `54.88.29.72`:

```bash
ssh -i demoapp_prodkey.pem ec2-user@54.88.29.72

# To change to root user after login use
sudo su
```

# To delete the key pair

```bash
aws ec2 delete-key-pair --key-name demoapp_prodkey
```

## To create new ElasticBeanstalk application:

```bash
aws elasticbeanstalk create-application --application-name demo-app --description ""
```

## To get a list of available solutions stacks:

```bash
aws elasticbeanstalk list-available-solution-stacks

# or filtered 64 bit PHP stacks
aws elasticbeanstalk list-available-solution-stacks | grep -i 64bit.*PHP
```

## To create new ElasticBeanstalk environment:

```bash
aws elasticbeanstalk create-environment \
    --application-name demo-app \
    --environment-name demo-prod-env \
    --description "" \
    --option-settings file://.ebextensions/env/prod-single.json \
    --solution-stack-name "64bit Amazon Linux 2014.03 v1.0.4 running PHP 5.5"
```

## To update existing ElasticBeanstalk environment:

```bash
aws elasticbeanstalk update-environment \
    --environment-name demo-prod-env \
    --option-settings file://.ebextensions/env/prod-variables.json

# environment options can also be updated without using a file, as an example
aws elasticbeanstalk update-environment \
    --environment-name demo-prod-env \
    --option-settings \
        Namespace=aws:elasticbeanstalk:application:environment,OptionName=AWS_ACCESS_KEY_ID,Value= \
        Namespace=aws:elasticbeanstalk:application:environment,OptionName=AWS_SECRET_KEY,Value=
```

## To create an IAM role:

```bash
aws iam create-instance-profile \
    --instance-profile-name aws-elasticbeanstalk-ec2-role

aws iam create-role \
    --role-name aws-elasticbeanstalk-ec2-role \
    --assume-role-policy-document file://./.ebxtensions/misc/aws-elasticbeanstalk-ec2-role-trust-policy.json

aws iam add-role-to-instance-profile \
    --instance-profile-name aws-elasticbeanstalk-ec2-role \
    --role-name aws-elasticbeanstalk-ec2-role
```

## To create a user for git aws.push

```bash
aws iam create-group --group-name gitAwsPush

aws iam put-group-policy \
    --group-name gitAwsPush \
    --policy-document file://./.ebextensions/misc/gitAwsPush-Group-Policy.json \
    --policy-name gitAwsPush-Group-Policy

aws iam create-user --user-name eb

aws iam add-user-to-group --user-name eb --group-name gitAwsPush
```

## To delete the environment

```bash
aws elasticbeanstalk terminate-environment \
    --environment-name demo-prod-env \
    --terminate-resources
```

# To delete the application

```bash
aws elasticbeanstalk delete-application \
    --application-name demo-app \
    --terminate-env-by-force
```
