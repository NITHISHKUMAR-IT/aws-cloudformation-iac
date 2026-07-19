# CloudFormation Learning Notes

## Template vs Stack

```text
Template = YAML blueprint
Stack = Real deployed AWS resources
```

## Important Sections

- **Parameters** make the template reusable.
- **Resources** define AWS infrastructure.
- **Outputs** return useful deployment values.

## Intrinsic Functions Used

| Function | Purpose |
|---|---|
| `Ref` | Reads a parameter or resource value |
| `Fn::Sub` | Substitutes variables into strings |
| `Fn::GetAtt` | Reads a resource attribute |
| `Fn::Select` | Selects one item from a list |
| `Fn::GetAZs` | Returns Availability Zones |
| `Fn::Base64` | Encodes EC2 user data |

## Lifecycle Concepts

- Rollback removes partially created resources after failure.
- Change Sets preview stack modifications.
- Drift Detection finds manual changes outside CloudFormation.
- Stack deletion removes managed resources in dependency order.
