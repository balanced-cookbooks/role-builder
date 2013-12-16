role-builder
============

Role for building and publishing our packages.


Provision
=========

Your stuff should all be checked out e.g. here:

```bash
$ cd ~/code/bp/chef
$ echo $CONFUCIUS_ROOT
/code/bp/chef/confucius
```

So now you can just so something like:

```bash
$ knife ec2 server create \
--image ami-aa4070ef \
--flavor m1.large \
--region us-west-1 \
--security-group=sg-1da07459 \
--iam-profile builder \
--identity-file ~/.ssh/aws-pp-ai-gazelle.pem \
--run-list "role[builder]"
...
Instance ID: i-3060fb6d
Flavor: m1.large
Image: ami-aa4070ef
Region: us-west-1
Availability Zone: us-west-1a
Security Groups: default
Security Group Ids: default
IAM Profile: builder
Tags: Name: i-3060fb6d
SSH Key: ai-gazelle
Root Device Type: instance-store
Public DNS Name: ec2-54-215-54-1.us-west-1.compute.amazonaws.com
Public IP Address: 54.215.54.1
Private DNS Name: ip-10-197-83-93.us-west-1.compute.internal
Private IP Address: 10.197.83.93
Environment: dev
Run List: role[builder]
```

Make sure you terminate it once you're done:

```bash
$ ec2-terminate-instance i-3060fb6d
```

Or if you're hacking locally:

```bash
$ cd cookbooks/role-builder
$ vagrant up --provision
```

Using it
========

Consult whatever you are building/publishing how to build and publish, e.g. for
[balanced virtualenv](https://github.com/Poundpay/balanced) you just do:

```bash
$ cd ~/code/bp/balanced/confucius/lib
$ fab -H ec2-54-215-54-1.us-west-1.compute.amazonaws.com build_venv_package:1.1.0,upload=True
...
```
