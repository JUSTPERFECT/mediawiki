# mediawiki

automating mediawiki stack on AWS

Tools Used: Jenkins, packer, Jenkins

Jenkins URL: https://jenkins.whyinfra.com

username: mediawiki
password: mediawiki

Configured Job URL: https://jenkins.whyinfra.com/job/mediawiki

parameters:

ENVIRONMENT ( environment to deploy the app)
APPLICATION (selecting application)
ACTION (terraform action[ plan or apply ] to do)
PACKER_BUILD (Flag decides whether to run packer steps or not)

Immutable Infrastructure:
packer is being used to create customized AMI for application
terraform is being used to provision infrastructure from that image.
