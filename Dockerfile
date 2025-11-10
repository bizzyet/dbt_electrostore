FROM python:3.12-slim

# Set working directory
WORKDIR /usr/app/dbt

# Install system dependencies for SQL Server ODBC Driver
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    apt-transport-https \
    unixodbc-dev \
    git \
    && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
    && echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install uv and dependencies
RUN pip install --no-cache-dir uv && uv sync --frozen

# Copy dbt project files
COPY dbt/ ./dbt/
COPY profiles.yml ./

# Set environment variable for dbt profiles directory
ENV DBT_PROFILES_DIR=/usr/app/dbt

# Use uv run as entrypoint with dbt
ENTRYPOINT ["uv", "run", "dbt"]

# Default command (can be overridden)
CMD ["run"]
