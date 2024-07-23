FROM ubuntu:latest

# Install OpenSSH and other necessary packages
RUN apt-get update && apt-get install -y openssh-server git

# Set the container's working directory
WORKDIR /git-server/

# Copy the SSH keys and setup script into the container
COPY ./keys /git-svr/keys
COPY setup.sh /git-server/

# Make the setup script executable
RUN chmod +x /git-server/setup.sh

# Expose SSH port
EXPOSE 22

# Run the setup script
CMD ["/git-server/setup.sh"]