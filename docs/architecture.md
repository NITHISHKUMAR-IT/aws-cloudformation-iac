# Architecture Design

```mermaid
flowchart TB
    CFN[AWS CloudFormation]
    VPC[Custom VPC 10.20.0.0/16]
    IGW[Internet Gateway]
    Subnet[Public Subnet 10.20.1.0/24]
    RT[Public Route Table]
    SG[Security Group: HTTP 80]
    IAM[IAM Role + Instance Profile]
    EC2[Amazon Linux 2023 EC2]
    Nginx[Nginx Website]
    SSM[AWS Systems Manager]

    CFN --> VPC
    CFN --> IGW
    CFN --> Subnet
    CFN --> RT
    CFN --> SG
    CFN --> IAM
    CFN --> EC2
    IGW --> RT
    RT --> Subnet
    Subnet --> EC2
    SG --> EC2
    IAM --> EC2
    EC2 --> Nginx
    SSM --> EC2
```

## Design Decisions

- Custom VPC avoids dependency on the default VPC.
- Public subnet provides internet access for Nginx.
- No inbound SSH rule is created.
- Session Manager replaces key-based SSH administration.
- IMDSv2 and encrypted gp3 storage strengthen the instance configuration.
