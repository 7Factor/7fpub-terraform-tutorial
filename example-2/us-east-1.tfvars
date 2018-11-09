// A reminder that a file like this should never be but into source control

// our vpc id, this was created by our network terraform
vpc_id = "vpc-0a2b4071"
// public subnets for the load balancer
public_subnets = ["subnet-0443e8abf3640567b", "subnet-0f8fab4961bf568d4"]
// privat subnets for the ec2"s
private_subnets = ["subnet-00dab7576351ed8bd","subnet-0619a20a7806d1e7d"]
// we want to be able to ssh into our ec2's
utility_accessible_sg = "sg-0ab93a49e6ab42173"
// this was created manually through the console.
pem_key = "tutorial-key-us-east-1"
// it's a good idea to get into the habit of tagging like this
cluster_name = "Example 2 Cluster"

