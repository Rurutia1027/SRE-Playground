- **Amazon Snowball Edge Devices**
Amazon Snowball Edge devices are physical data transfer appliances designed to help business securely and efficiently transfer large amounts of data to and from the AWS Cloud. They are part of the **AWS Snow Family**, which includes services for moving data either online or offline, especially when dealing with large-scale datasets. 

--- 

- **AWS Cloud**
A comprehensive cloud computing platform offering over 200 services for storage, compute, database, networking, machine learning, and more. 

It provides the infrastructure and tools to build, and manage applications in the cloud.  
Examples of Services: 
* Compute: EC2, Lambda
* Database: RDS, DynamoDB
* Storage: S3, EBS, Glacier 
* Networking: VPC, Route 53
* AI/ML: SageMaker, Rekognition 

--- 

- **Amazon S3(Simple Storage Service)** 
A storage service in AWS Cloud for storing objects(files, data) in highly scalable, secure, and durable storage. 

--- 

- **Snowball Edge**
Part of the AWS Snow Family for data migration.  A physical device used to transfer large amounts of data to and from the AWS Cloud when traditional network transfers are impractical. Unlike Amazon S3, which operate entirely online, Snowball Edge involves offline physical data transfer. Snowball Edge is a hardware appliance that helps customers collect and pre-process data in remote location or migrate data into Amazon S3. 

--- 

- **10-day free period**: 
    - You will be charged a daily rental fee, which varies depending on the region and the type of Snowball Edge device. 
    - Data Transfer Costs: Data uploaded from Snowball Edge to AWS services (e.g. S3) is free. Data downloaed from AWS (e.g., from S3 to Snowball Edge) incurs standard AWS data transfer out fees. 
    - Shipping Fees: AWS covers standard shipping costs for delivering and returning the Snowball Edge device in many regions, but expedited shipping or international shipping may incur extra charges. 
    - Snowball Edge Pricing by Device Type:
      - There are three types of Snowball Edge devices, each catering to specific use causes: 
      - Storage Optimized: Focused on data migration and storage with up to 80 TB usable capacity.
      - Compute Optimized: Includes higher compute capabilities for edge applications, supporting EC2 instances and Lambda functions. 
      - Compute Optimized with GPU: Design for machine learning, video processing, and high-performance computing at the edge. 