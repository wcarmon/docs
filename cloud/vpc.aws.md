# Overview
1.  Virtual Private Cloud (VPC) [AWS](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)


# Definitions
- **Region**:
    - A physical data center "campus"
    - https://aws.amazon.com/about-aws/global-infrastructure/regions_az/#
- **Availability  Zone**:
    - A physical data center "building"
- **VPC**:
    - A (virtual) network
    - logically isolated
    - Associated to your AWS account
    - contains 1+ non-overlapping Subnets
    - Traffic enters thru peered VPCs, internet or a VPN connection
    - Has 0 or 1 Internet Gateway
- **Subnet**: Range of IP addresses in your VPC
    - [**CIDR**](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing): a format for defining an IPv4 range. [AWS](https://docs.aws.amazon.com/vpc/latest/userguide/how-it-works.html#vpc-ip-addressing)
    - Resources are launched in a Subnet
    - Public subnets are accessible from the Internet
    - Subnet >|o----|- Router
    - Subnet >|o----|- Network ACL
    - Private IP (Private Subnet): not reachable from the Internet (eg. database)
    - Public IP (Public Subnet): reachable from the Internet
    - Elastic IP: ...TODO...
- **Resource**:
    - TODO
    - eg. EC2
- **Gateway**:
    - Connects your VPC to another network
    - **Internet Gateway (IGW)**:
        - connects your VPC to the (public) internet
        - logical connection between VPC and internet
        - This is the **only way** to connect VPC to the public internet
        - Allows instances with public IP to connect to the internet (eg. a public NAT Gateway)
    - **NAT Gateway (NGW)**:
        - **N**etwork **A**ddress **T**ranslation
        - Forwards traffic
        - A facade/proxy that partially "exposes" private resource
        - Allows resources/instances in a private subnet to connect to services outside your VPC
        - Prevents external services from initiate a connection with private resources/instances
        - Prevents unsolicited inbound connections from the internet
        - Private resources/instances should never access the Internet directly
        - Private resources should always go through the **NAT gateway**
        - Usage: create a public NAT gateway in a public subnet
        - Usage: Associate an elastic IP address with the NAT gateway at creation
        - Usage: route traffic from the NAT gateway to VPC's internet gateway
        - Protocols: TCP, UDP, and ICMP
        - Bound to one Availability Zone
    - **Private Gateway**:
        - connects your VPC to your own network
- **Route table** ([AWS](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html#RouteTables))
    - Is a ...TODO
    - Contains 1+ Routes
- **Route**
    - [Official docs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)
    - Determine where network traffic from your subnet or gateway is directed
    - Has destination (eg. IP range or subnet as [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing))
    - Has target (eg. Gateway, Peering Connection, Gateway Load Balancer endpoint, network interface, Network ACL, ...)
- **Security groups**
    - Protects instances (?TODO?)
    - Control inbound and outbound traffic
    - Supports allow rules only
    - Higher level concept than Network ACL ([AWS](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Security.html#VPC_Security_Comparison))
- **Network ACLs**
    - Network **A**ccess **C**ontrol **L**ists (ACL)
    - Protects subnets
    - control inbound and outbound traffic for 1+ subnets
    - Not used for traffic WITHIN the subnet
    - Sometimes overkill, just use Security Group
    - Stateless
    - Supports allow rules and deny rules
- **Load Balancer**
    - ALB: [Application Load Balancer](TODO)
    - ELB: [Elastic Load Balancer](TODO)
    - TODO: ssl termination
    - TODO: relation to other concepts
- **Peering Connection**
    - [Official Docs](https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html)
    - routes traffic between two VPCs (share network traffic)
    - Must be in same region (TODO: verify)
    - Peering is **not** transitive


# Hierarchy
- Region / VPC / Availability Zone / Security Group / Subnet / Resource
- Region / VPC / Availability Zone / NAT gateway
- Region / VPC / Internet Gateway
- Region / VPC / Router / Subnet
- Network ACL / Subnet


# Cost
1. [AWS doesn't charge for VPC](https://aws.amazon.com/vpc/pricing/) (not directly)


# CIDR
|Netmask|#IP addresses|
|---|---|
|`/20`|`4,096`|

- TODO: more here


- TODO: VPC endpoint - private connection to AWS services without internet gateway
- TODO: debugging - TODO: "Linting" security setup
- TODO: DHCP
- TODO: NAT gateway vs Internet gateway
- TODO: NAT gateway belongs to subnet?
- TODO: VPC has multiple NAT gateways?
- TODO: can you share Internet gateways between VPCs?

# Other resources
1. https://aws.amazon.com/vpc/
