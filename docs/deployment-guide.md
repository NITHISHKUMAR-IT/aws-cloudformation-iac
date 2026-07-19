# Deployment Guide

## Console Deployment

1. Open **AWS CloudFormation**.
2. Choose **Create stack → With new resources**.
3. Choose **Upload a template file**.
4. Upload `template.yaml`.
5. Stack name: `nithish-cloudformation-web`.
6. Keep `Environment=dev` and `InstanceType=t3.micro`.
7. Acknowledge creation of named IAM resources.
8. Submit and wait for `CREATE_COMPLETE`.

## Verification

Open the stack and review:

```text
Events
Resources
Outputs
Parameters
Template
```

Open the `WebsiteURL` output. Then validate through Session Manager:

```bash
systemctl status nginx
curl -I http://localhost
```

Expected:

```text
active (running)
HTTP/1.1 200 OK
```

## Cleanup

Delete the stack through CloudFormation and wait for `DELETE_COMPLETE`.
