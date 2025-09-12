# Intro to AWS

- [Intro to AWS](#intro-to-aws)
    - [What is AWS?](#what-is-aws)
    - [Marketshare and use cases for AWS](#marketshare-and-use-cases-for-aws)
    - [How is AWS structures globally?](#how-is-aws-structures-globally)
    - [What are AWS regions?](#what-are-aws-regions)
    - [What are AWS availability zones?](#what-are-aws-availability-zones)
    - [What are AWS Points of Presence/Edge locations?](#what-are-aws-points-of-presenceedge-locations)
    - [How to create an instance on AWS?](#how-to-create-an-instance-on-aws)


### What is AWS?
* Amazon Web Services
* 2002 Internal launch
* 2004 Public launch
  
### Marketshare and use cases for AWS
* Netflix
* McDonalds
* AirBnB
* Expedia
* Samsung
* Nasa
* Facebook/Meta
* Adobe
* Twitch
* BBC
* Twitter
* Pfizer
* BMW
* Coursera
* Ubisoft

### How is AWS structures globally? 
* Regions broken into Availability Zones (AZs)
* Each availability zone is made up of a data center (cluster of data centres)

Benefits for a business:
* Low Latency
* Possible to save money depending on the region
* Data compliance
  
### What are AWS regions?
* Cannot be close by. Need to be spaced out. 
* 38 launched regions each with multiple Availability Zones

### What are AWS availability zones?
* 120 Availability Zones
* 43 Local Zones and 31 Wavelength Zones for ultra-low latency applications

### What are AWS Points of Presence/Edge locations?
* 700+ CloudFront POPs AND 13 Regional edge caches

### How to create an instance on AWS?
- naming convention: tech511-xyz-afsheen
- ubuntu
- image - 22.04 version- app we need to run works well on 22.04, commands might not work on 24.04
- instance type t3.micro
- select ur key pair - cant login if u dont use ur key pair
- security group -> existing group -> find yours