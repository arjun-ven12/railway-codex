FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js, git, tmux, ttyd, and build dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    tmux \
    ttyd \
    build-essential \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Codex CLI globally
RUN npm install -g @openai/codex

# Set working directory
WORKDIR /workspace

# Start ttyd on Railway's dynamic PORT, launching tmux for persistent sessions
CMD ttyd -p $PORT -c $TERMINAL_USER:$TERMINAL_PASSWORD tmux new-session -A -s codex-remote