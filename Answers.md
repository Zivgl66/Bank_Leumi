# Answers to the question 2 - 4

## Question 2a:

The TEST EC2 machine fails to resolve DNS for internet addresses. What are the points of failure to examine?

- **VPC DNS Settings**: Verify if the VPC where the TEST EC2 resides has DNS resolution and DNS hostnames enabled.
- **NAT Gateway**: Ensure that the NAT Gateway in the EGRESS VPC is properly configured to allow DNS traffic (port 53).
- **NFW (Network Firewall)**: Check if the firewall allows outbound DNS traffic (UDP/TCP port 53).
- **Route to DEV Transit Gateway (TGW)**: Confirm that the TEST Spoke VPC has a route to the DEV TGW, which can forward DNS queries to the internet.
- **Transit Gateway Association**: Verify that the TGW associations and routing tables are configured to allow DNS traffic between the TEST Spoke VPC and the EGRESS VPC (or internet via NAT Gateway).
- **DNS Server Configuration on EC2**: Check that the DNS server settings on the TEST EC2 instance are correct and point to valid DNS servers (such as Amazon-provided DNS or custom DNS).

## Question 2b:

he TEST EC2 machine receives DNS address translation but fails to communicate with the Internet. What could be the source of the problem?

- **NAT Gateway Configuration**: The EC2 instance might be able to resolve DNS addresses, but without a properly configured NAT Gateway in the EGRESS - VPC, it will not be able to establish outbound connections.
- Network Firewall Rules: Ensure that the NFW in the EGRESS VPC is allowing the relevant outbound traffic (e.g., HTTP/HTTPS traffic on port 80 and 443).
- **Route Table Configuration**: Double-check the route tables in both the TEST Spoke VPC and EGRESS VPC. Make sure that traffic destined for the internet is correctly routed through the DEV TGW and to the NAT Gateway.
- **Security Groups/Network ACLs**: Verify that the security groups and NACLs associated with the TEST EC2 and NAT Gateway are configured to allow outbound internet traffic.
- **EC2 Instance Security Group**: Ensure that the security group attached to the TEST EC2 allows outbound access to ports 80 (HTTP) and 443 (HTTPS).

## Question 2c:

On the TEST EC2 machine, Docker engine is installed. Its repository is in the ALM Spoke VPC on the Nexus repo machine. What would you check for the following errors?

1.  Error 1: Pull access denied
    Docker Credentials: Ensure that the credentials to access the Nexus repository are correct and provided in Docker's configuration on the TEST EC2 instance.
    Repository Permissions: Verify that the Nexus repository has appropriate permissions to allow the TEST EC2 to pull images from it.
    DNS Resolution: Ensure that the Nexus EC2 in the ALM Spoke VPC is reachable via DNS or its IP address from the TEST EC2 instance.

2.  Error 2: Container pull timeout
    Network Connectivity: Check if there is any network issue between the TEST EC2 and the Nexus EC2 instance in the ALM Spoke VPC (e.g., route issues, security groups, or NACLs blocking traffic).
    Nexus Repo Health: Verify if the Nexus repository service is running properly and not facing high latency or timeouts.
    Bandwidth/Throughput Limits: Ensure there are no bandwidth limitations that might be causing the connection to timeout.

3.  Error 3: Docker daemon is not running
    Docker Daemon: Check whether the Docker daemon is running on the TEST EC2 machine by running sudo systemctl status docker.
    Docker Logs: Review Docker logs (/var/log/docker.log) for any errors or crashes.
    Docker Installation: Verify that Docker is installed correctly by running docker --version and restarting the Docker service using sudo systemctl start docker.

## Question 3:

Externalizing a service to the Internet based on a DNS record and referencing the TEST EC2 machine. When accessing from the outside, you get the public address of the machine but are unable to surf the service in HTTPS. What would you check?

- **Security Groups**: Ensure the security group attached to the TEST EC2 instance allows inbound traffic on port 443 (HTTPS).
- **NAT Gateway and Routing**: Verify that the NAT Gateway and route tables are configured to route inbound HTTPS traffic from the internet to the EC2 instance.
- **Network Firewall (NFW) Rules**: Check if the NFW allows inbound HTTPS traffic from the internet.
- **TLS/SSL Certificates**: Ensure that the HTTPS service on the TEST EC2 machine has valid SSL certificates installed.
- **Web Server Configuration**: Confirm that the web server (e.g., Nginx, Apache) on the TEST EC2 is configured correctly to serve traffic over HTTPS.
- **DNS Record**: Ensure that the DNS record points to the correct public IP of the TEST EC2 machine.

## Question 4:

When trying to telnet from the TEST EC2 machine, an error is received that this software is missing. How will you install it on Amazon Linux 2? What could be the cause of its installation failure, what repo and with what command would you solve it?

Installation:
To install telnet on Amazon Linux 2, run the following command:

```
sudo yum install telnet -y
```

Possible Causes of Installation Failure:
Yum Repository Unavailable: If the yum package manager cannot access repositories, check network connectivity and DNS resolution on the TEST EC2 machine.
Repository Misconfiguration: If the Amazon Linux 2 repositories are not correctly configured, check the /etc/yum.repos.d/ directory for the correct repo configuration.
Resolving Repo Issues:
To re-enable or update the repository, you can use the following command to install and enable necessary repositories:

```
sudo yum install -y amazon-linux-extras
sudo amazon-linux-extras enable epel
```

If the issue persists, ensure the EC2 instance can reach the appropriate repository URLs by verifying its internet connectivity and route configurations.
