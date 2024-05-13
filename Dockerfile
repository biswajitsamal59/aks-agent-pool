FROM ubuntu:20.04

# Set up environment to avoid interactive dialog from apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies for .NET
RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    unzip \
    tar \
    # Add dependencies for .NET 6
    libicu66 \
    libssl1.1 \
    ca-certificates \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Generate locale for internationalization support
RUN locale-gen en_US.UTF-8

# Create a non-root user
RUN useradd -m azureuser

# Install Azure DevOps Agent
WORKDIR /agent
RUN curl -LsS https://vstsagentpackage.azureedge.net/agent/3.239.1/vsts-agent-linux-x64-3.239.1.tar.gz | tar -xz -C /agent

# Change ownership to non-root user
RUN chown -R azureuser:azureuser /agent

# Change permissions before switching user
COPY start.sh .
RUN chmod +x start.sh

USER azureuser

CMD ["./start.sh"]
