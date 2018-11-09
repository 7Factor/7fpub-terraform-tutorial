// create the instance(s)
resource "aws_instance" "example_2_instance" {
  count = "${var.instance_count}"

  // We're doing some magic here to allow for any number of count that's evenly distributed
  // across the configured subnets.
  ami = "${data.aws_ami.aws_linux.id}"

  instance_type = "${var.instance_type}"
  subnet_id     = "${var.private_subnets[count.index % length(var.private_subnets)]}"

  key_name = "${var.pem_key}"

  vpc_security_group_ids = [
    "${aws_security_group.example_2_sg.id}",
    "${var.utility_accessible_sg}",
  ]

  // start up scripts to build a simple web server
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sudo yum -y install docker",
      "mkdir html",
      "echo '<html><body><h1>Hello World</h1><p>Welcome to my Terraformed Box Number ${self.count}!</p></body></html>' > html/index.html",
      "sudo service docker start",
      "sudo usermod -aG docker ec2-user",
      "sudo docker pull nginx",
      "sudo docker run -d --name example-2 -p 80:80 -v html:/usr/share/nginx/html nginx:latest",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = "${self.private_ip}"
      private_key = "${file("${path.root}/${var.pem_key}.pem")}"
    }
  }

  tags {
    Name    = "Example 2 Server No. ${count.index + 1}"
    Cluster = "${var.cluster_name}"
  }
}
