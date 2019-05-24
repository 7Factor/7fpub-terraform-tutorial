// our vpc id, this was created by our network terraform
vpc_id = "vpc-0e6ce80c5861c0584"
// public subnets for the load balancer
public_subnets = ["subnet-0620394bc9b89c2fe", "subnet-035d2af47fb873744"]
// privat subnets for the ec2"s
private_subnets = ["subnet-082ac19a5e55f8736","subnet-0830c1406c1904fa4"]
// ssh in ec2's from utility host
utility_accessible_sg = "sg-0e7348f1fe06d0d6b"
// this was created manually through the console.
pem_key = "example-2-us-east-1.pem"
// it's a good idea to get into the habit of tagging like this
cluster_name = "Example 2 Cluster"

