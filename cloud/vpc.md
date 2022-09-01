# Overview
1.  Virtual Private Cloud (VPC) [AWS](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)


# Definitions
- **Region**:
    - TODO
- **Availability  Zone**:
    - TODO
- **VPC**:
    - A (virtual) network
    - logically isolated
    - Associated to your AWS account
    - contains 1+ non-overlapping Subnets
- **Subnet**: Range of IP addresses in your VPC
    - [**CIDR**](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing): a format for defining an IPv4 range. [AWS](https://docs.aws.amazon.com/vpc/latest/userguide/how-it-works.html#vpc-ip-addressing)
    - Resources are launched in a Subnet
    - Public subnets are accessible from the Internet
- **Resource**: eg. EC2
- **Gateway**:
    - Connects your VPC to another network
    - **Internet Gateway**: connects your VPC to the internet
- **Route table** ([AWS](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html#RouteTables))
    - Is a ...TODO
    - Contains 1+ Routes
- **Route**
    - Determine where network traffic from your subnet or gateway is directed


# Hierarchy
- Region / VPC / Availability Zone / Subnet / Resource


# Benefits
1. Control over ...
    1. resource placement
    1. resource connectivity
    1. resource security


# Cost
1. [AWS doesn't charge for VPC](https://aws.amazon.com/vpc/pricing/) (not directly)


# Inter VPC communication (Share network traffic)
- TDOO: Availability Zones
- TODO: AWS Regions


- TODO: subnet
- TODO: load balancers
- TODO: Gateway
- TODO: Route tables / Route - https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html
- TODO: NAT
- TODO: VPC endpoint - private connection to AWS services without internet gateway
- TODO: VPC peering connection - routes traffic between two VPCs - https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html
- TODO: google cloud
- TODO: DHCP
- TODO: network access control lists (ACL)


# Other resources
1. https://aws.amazon.com/vpc/
