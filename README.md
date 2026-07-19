# AWS CloudFormation Infrastructure as Code

A production-inspired Infrastructure as Code project that provisions a complete public Nginx web-server environment using AWS CloudFormation.

> **Current status:** Template ready. Real AWS deployment and evidence collection are pending.

## Project Goal

```text
CloudFormation Stack
├── Custom VPC
├── Internet Gateway
├── Public Subnet
├── Route Table and Public Route
├── Security Group
├── IAM Role and Instance Profile
└── Amazon EC2
    └── Amazon Linux 2023
        └── Nginx Website
```

## Why CloudFormation?

Manual infrastructure creation is slow and difficult to reproduce. CloudFormation stores infrastructure as version-controlled YAML so the same environment can be created, reviewed, updated, and deleted predictably.

## Security Design

- SSH port 22 is not opened.
- Administration uses AWS Systems Manager Session Manager.
- IMDSv2 is required.
- The root EBS volume is encrypted.
- HTTP port 80 is the only public inbound rule.
- IAM permissions use the managed `AmazonSSMManagedInstanceCore` policy.

flowchart LR
    User[User Browser]
    Admin[Administrator]
    Internet[Internet]
    SSM[AWS Systems Manager]

    subgraph VPC[Custom VPC 10.20.0.0/16]
        IGW[Internet Gateway]

        subgraph PublicSubnet[Public Subnet 10.20.1.0/24]
            RT[Public Route Table<br>0.0.0.0/0 → IGW]
            SG[Security Group<br>HTTP 80 Allowed]
            EC2[Amazon EC2<br>Amazon Linux 2023]
            IAM[IAM Role + Instance Profile]
            Nginx[Nginx Website]
        end
    end

    User -->|HTTP 80| Internet
    Internet --> IGW
    IGW --> RT
    RT --> EC2
    SG --> EC2
    IAM --> EC2
    EC2 --> Nginx

    Admin --> SSM
    SSM -->|Secure Session via HTTPS| EC2
```

## Repository Structure

```text
aws-cloudformation-iac/
├── README.md
├── LICENSE
├── .gitignore
├── index.html
├── template.yaml
├── parameters/
│   └── dev.json
├── docs/
│   ├── architecture.md
│   ├── deployment-guide.md
│   └── learning-notes.md
├── scripts/
│   ├── validate-template.ps1
│   ├── deploy-stack.ps1
│   └── delete-stack.ps1
└── screenshots/
    └── README.md
```

## Resources Created

| Resource | CloudFormation Type |
|---|---|
| VPC | `AWS::EC2::VPC` |
| Internet Gateway | `AWS::EC2::InternetGateway` |
| Public Subnet | `AWS::EC2::Subnet` |
| Route Table | `AWS::EC2::RouteTable` |
| Security Group | `AWS::EC2::SecurityGroup` |
| IAM Role | `AWS::IAM::Role` |
| Instance Profile | `AWS::IAM::InstanceProfile` |
| EC2 Instance | `AWS::EC2::Instance` |

## Validate

```powershell
.\scriptsalidate-template.ps1
```

## Deploy

```powershell
.\scripts\deploy-stack.ps1
```

The deployment requires `CAPABILITY_NAMED_IAM` because the template creates named IAM resources.

## Verify

After the stack reaches `CREATE_COMPLETE`:

1. Review **Events**.
2. Review **Resources**.
3. Review **Outputs**.
4. Open `WebsiteURL`.
5. Confirm the Nginx landing page loads.
6. Use Systems Manager Session Manager to verify the instance without SSH.

## Delete

```powershell
.\scripts\delete-stack.ps1
```

## Evidence Required

```text
screenshots/
├── 01-template-validation.png
├── 02-stack-create-complete.png
├── 03-stack-resources.png
├── 04-stack-outputs.png
├── 05-live-website.png
├── 06-session-manager.png
└── 07-stack-delete-complete.png
```

The project must remain **In Progress** until real deployment evidence is added.

## Current Status

```text
Template design       Completed
Repository files      Completed
Template validation   Pending
Stack deployment      Pending
Website verification  Pending
Evidence collection   Pending
Stack deletion        Pending
```

## Author

**Nithishkumar K**

- GitHub: https://github.com/NITHISHKUMAR-IT
- Portfolio: https://nithishkumar-it.github.io/nithishkumar-cloud-portfolio/
- Email: nithishdev29@gmail.com
- LinkedIn: https://www.linkedin.com/in/nithishkumar-k-072726388

## License

Licensed under the [MIT License](LICENSE).
