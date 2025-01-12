# IAM: Identity and Access Management

## IAM: Users & Groups

- IAM = Identity and Access Management, **Global** service.
- **Root account**: Created by default, shouldn't be used or shared.
- **User**: are people within your organization, and can be grouped.
- Users don't have to belong to a group, and user can belong to multiple groups. (User : Group => M : N)

--- 

## IAM: Permission

- **Users** or **Groups**: Can be assigned JSON documents called **policies**.

```json 
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:Describe",
      "Resources": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricsStatistics",
        "cloudwatch: Describe"
      ],
      "Resource": "*"
    }
  ]
}
```

- These policies define the **permissions** of the users.
- In AWS you apply the **least privilege principle**: don't give more permissions than a user needs.

--- 

## IAM Policies Structure

- Consists of
    - Version: policy language version, always include "2012-10-17"
    - Id: an identifier for the policy (optional)
    - Statement: one or more individual statements (required)
- Statements consists of
    - Sid: an identifier for the statement (optional)
    - Effect: whether the statement allows or denies access (Allow, Deny).
    - Principal: account/user/role to which this policy applied to
    - Action: list of actions this policy allows or denies
    - Resource: list of resource to which actions applied to
    - Condition: conditions for when this policy is in effect (optional)

--- 

## IAM - Password Policy

- Strong password = higher security for your account.
- In AWS, you can setup a password policy:
    - Set a minimum password length
    - Require specific character types:
    - Allow all IAM users to change their own passwords
    - Require users to change their password after some time (password expiration)
    - Prevent password re-use

---

## Multi Factor Authentication - MFA

- Users have access to your account and can possibly change configurations or delete resources in your AWS account.
- You want to protect your Root Accounts and IAM users.
- **MFA = password you know + security device you own.**
- Main benefit of MFA: if a password is stolen or hacked, the account is not compromised.

--- 

## MFA devices options in AWS

- Virtual MFA device
    - Google Authenticator (phone only)
    - Authy (phone only)
- Universal 2nd Factor(U2F) Security Key
    - YubiKey
- Hardware Key Fob MFA Device
- Hardware Key Fob MFA Device for AWS GovCloud