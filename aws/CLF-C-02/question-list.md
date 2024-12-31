# Question & Answer List

## Topic 1 - Exam A

### Question 1

**A company plans to use an Amazon Snowball Edge device to transfer files to AWS Cloud.
Which activities related to a Snowball Edge device are available to the company at no cost?**

A. Use of the Snowball Edge appliance for a 10-day period.
B. The transfer of data out of Amazon S3 and to the Snowball Edge appliance.
C. The transfer of data from the Snowball Edge appliance into Amazon S3.
D. Daily use of the Snowball Edge appliance after 10 days.

### Answer: A

### Notes

- **Amazon Snowball Edge devices**:

--- 

### Question 2

**A company has deployed applications on Amazon EC2 instances. The company needs to assess application vulnerabilities
and must identify infrastructure deployments that do not meet best practices. Which

### Answer

A. AWS Trusted Advisor
**B. Amazon Inspector**
C. AWS Config
D. Amazon GuardDuty

### Notes

Explanation: Amazon Inspector assesses application vulnerabilities and identifies potential security issues in EC2
instance, helping ensure infrastructure deployments meet best practices.

#### **AWS Trusted Advisor** 
* Provides guidance on optimizing resources, improving security, reducing costs, and following best practices in AWS. This checks for unused resources or overly permissive security settings. Offers cost-saving recommendations and performance improvements.
* Example Use Case: Identifying underutilized EC2 instances or ensuring S3 bucket permissions are secure. 
* Limitations: Focuses on resource optimization and configuration best practices, not vulnerability assessment. 

#### **Amazon Inspector(Correct Answer)** 
* Usage: Automatically assesses application vulnerabilities and EC2 instance misconfigurations. 
* Scans for software vulnerabilities and compliance issues on EC2 instances, container images, and Lambda functions. 
* Generate a report with findings and severity levels. 
* Example Use Case: Finding outdated software package or unpatched CVEs(Common Vulnerabilities and Exposures).
* Why Correct: This service directly meets the need for application vulnerability assessment.

#### Amazon Config
* Usage: Monitors and evaluates AWS resource configurations against best practices and compliance rules.
* Tracks changes to configurations in AWS resources.
* Ensures compliance with standards like PCI DSS or HIPAA. 
* Example Use Case: Checking if S3 buckets are encrypted or EC2 instances are tagged properly.
* Limitations: Does not perform vulnerability scans on applications. 
--- 

#### Amazon GuardDuty
* Usage: Threat detection service for monitoring malicious activites or unauthorized access in your AWS environment. 
* Analyzes logs from CloudTrail, VPC Flow Logs, and DNS logs for suspicious activity.
* Detects brute force attacks, compromised EC2 instances, and unusal API calls.
* Example Use Case: Alerting on a potential DDoS attack targeting an application.
* Limitation: Focused on threat detection, not vulnerability assessment or best practices compliance. 