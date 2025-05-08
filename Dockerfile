FROM registry.fedoraproject.org/fedora:latest

# Install necessary tools
RUN dnf -y install enscript ghostscript && dnf clean all

# Create directories for input/output
RUN mkdir -p /opt/incoming /opt/outgoing

# Copy conversion script
COPY convert.sh /usr/local/bin/convert.sh
RUN chmod +x /usr/local/bin/convert.sh

# Default command to run script
CMD ["/usr/local/bin/convert.sh"]
FROM registry.fedoraproject.org/fedora:latest

# Install required tools
RUN dnf -y install enscript ghostscript && dnf clean all

# Create directories for input and output
RUN mkdir -p /opt/incoming /opt/outgoing

# Copy conversion script
COPY convert.sh /usr/local/bin/convert.sh
RUN chmod +x /usr/local/bin/convert.sh

# Run the script as default command
CMD ["/usr/local/bin/convert.sh"]

