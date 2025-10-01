# Dockerfile for Outscraper MCP Server
# Generated for Smithery deployment: https://smithery.ai/docs/build/project-config

FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml ./
COPY uv.lock* ./

# Install uv for faster dependency installation
RUN pip install --no-cache-dir uv

# Install dependencies using uv
RUN uv pip install --system --no-cache outscraper>=5.9.1 fastmcp>=2.8.0 python-dotenv>=1.1.0 uvicorn>=0.30.0 starlette>=0.37.0

# Copy application code
COPY outscraper_mcp_server/ ./outscraper_mcp_server/

# Expose port (configurable via PORT env var, defaults to 8000)
EXPOSE 8000

# Set environment variable defaults
ENV PYTHONUNBUFFERED=1

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD python -c "import requests; requests.get('http://localhost:8000/health', timeout=5)" || exit 1

# Run the HTTP server
CMD ["python", "-m", "outscraper_mcp_server.server_http"]
