# Answers

## Question 2a:

- **VPC DNS Settings**: First, I'd check the VPC settings to ensure that DNS resolution and DNS hostnames are enabled in the VPC where the EC2 instance is located.
- **NAT Gateway Configuration**: I'd confirm that the NAT Gateway in the EGRESS VPC is correctly set up to allow DNS traffic over port 53.
- **Network Firewall (NFW)**: I'd also check the firewall rules to make sure DNS traffic (UDP/TCP on port 53) is allowed outbound.
- **Route to Transit Gateway**: It's important to ensure that the TEST Spoke VPC has a route to the DEV Transit Gateway, which is responsible for forwarding DNS queries to the internet.
- **Transit Gateway Associations**: I'd verify that the Transit Gateway associations and routing tables are properly configured to allow DNS traffic between the TEST Spoke VPC and the EGRESS VPC (or NAT Gateway for internet access).
- **EC2 DNS Configuration**: Finally, I'd look at the DNS settings on the TEST EC2 instance itself, ensuring it’s pointing to valid DNS servers (like Amazon's default DNS or a custom one).

## Question 2b:

- **NAT Gateway Issues**: One possibility is that while DNS is resolving, the NAT Gateway in the EGRESS VPC isn't properly configured, preventing the EC2 from making outbound connections.
- **Firewall Rules**: I'd verify that the Network Firewall in the EGRESS VPC is allowing outbound traffic, specifically HTTP/HTTPS on ports 80 and 443.
- **Route Tables**: Another area to double-check would be the route tables in both the TEST Spoke and EGRESS VPCs. Traffic to the internet should route through the DEV TGW and the NAT Gateway correctly.
- **Security Groups and Network ACLs**: I’d also verify that both the security groups and NACLs for the EC2 instance and NAT Gateway allow outbound traffic to the internet.
- **Security Group on EC2**: Lastly, the security group attached to the EC2 instance should allow outbound traffic on ports 80 (HTTP) and 443 (HTTPS).

## Question 2c:

1. **Error 1: Pull Access Denied**

   - I'd start by checking the Docker credentials configured on the EC2 instance to ensure they have the correct access to the Nexus repository.
   - I’d also confirm that the Nexus repository has the appropriate permissions to allow the EC2 instance to pull images.
   - DNS resolution would be another thing to verify, ensuring that the Nexus EC2 in the ALM Spoke VPC is reachable from the TEST EC2, either by DNS or IP address.

2. **Error 2: Container Pull Timeout**

   - I'd first check network connectivity between the EC2 instance and the Nexus repo, ensuring there are no route issues, security group misconfigurations, or NACLs blocking traffic.
   - I'd also check the health of the Nexus repository to make sure it’s functioning properly and not experiencing latency or timeouts.
   - Lastly, I'd verify there aren’t any bandwidth limits or other factors affecting the connection between the two.

3. **Error 3: Docker Daemon Not Running**
   - I’d start by confirming whether the Docker daemon is running on the EC2 instance by running `sudo systemctl status docker`.
   - Checking the Docker logs (`/var/log/docker.log`) for any errors or crashes would be next.
   - Finally, I'd make sure Docker is installed correctly by running `docker --version` and restart the service if needed with `sudo systemctl start docker`.

## Question 3:

- **Security Group Configuration**: I'd ensure that the security group attached to the EC2 instance is allowing inbound traffic on port 443 (HTTPS).
- **NAT Gateway and Routing**: I’d verify that the NAT Gateway and route tables are properly routing inbound HTTPS traffic from the internet to the EC2 instance.
- **Firewall Rules**: The Network Firewall rules should be checked to confirm they allow inbound HTTPS traffic.
- **SSL/TLS Certificates**: I’d also make sure that the HTTPS service on the EC2 instance has valid SSL certificates installed and configured.
- **Web Server Settings**: I’d verify that the web server (e.g., Nginx, Apache) is set up correctly to handle HTTPS traffic.
- **DNS Record Accuracy**: Finally, I'd confirm that the DNS record points to the correct public IP address of the EC2 instance.

## Question 4:

- **Installing Telnet**: To install telnet on Amazon Linux 2, I would run:

  ```
  sudo yum install telnet -y
  ```

- **Possible Installation Failures**:

  - If the installation fails, one possibility could be that the `yum` repository is unavailable due to network connectivity issues or DNS resolution problems.
  - Another potential cause could be a misconfigured repository. I’d check the repo configuration files under `/etc/yum.repos.d/`.

- **Fixing Repo Issues**:

  - To fix repository issues, I would first install and enable the necessary repositories with:

    ```
    sudo yum install -y amazon-linux-extras
    sudo amazon-linux-extras enable epel
    ```

  - If the issue persists, I’d check the EC2 instance's internet connectivity and routing setup to ensure it can reach the correct repositories.
