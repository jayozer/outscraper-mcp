[![MseeP.ai Security Assessment Badge](https://mseep.net/pr/jayozer-outscraper-mcp-badge.png)](https://mseep.ai/app/jayozer-outscraper-mcp)

# Outscraper MCP Server

[![smithery badge](https://smithery.ai/badge/@jayozer/outscraper-mcp)](https://smithery.ai/server/@jayozer/outscraper-mcp)
[![PyPI version](https://badge.fury.io/py/outscraper-mcp.svg)](https://pypi.org/project/outscraper-mcp/)
[![Python 3.10+](https://img.shields.io/badge/python-3.10+-blue.svg)](https://www.python.org/downloads/)

A streamlined Model Context Protocol (MCP) server that provides access to Outscraper's Google Maps data extraction services. This server implements **2 essential tools** for extracting Google Maps data with high reliability.

## 🚀 Features

### Google Maps Data Extraction
- **🗺️ Google Maps Search** - Search for businesses and places with detailed information
- **⭐ Google Maps Reviews** - Extract customer reviews from any Google Maps place

### Advanced Capabilities
- **Data Enrichment** - Enhance results with additional contact information via enrichment parameter
- **Multi-language Support** - Search and extract data in different languages
- **Regional Filtering** - Target specific countries/regions for localized results
- **Flexible Sorting** - Sort reviews by relevance, date, rating, etc.
- **Time-based Filtering** - Filter reviews by date using cutoff parameter
- **High Volume Support** - Handles async processing for large requests automatically

## 📦 Installation

### Installing via Smithery (Recommended)

To install the Outscraper MCP server for Claude Desktop automatically via [Smithery](https://smithery.ai):

```bash
npx -y @smithery/cli install outscraper-mcp --client claude
```

### Installing via PyPI

```bash
# Using pip
pip install outscraper-mcp

# Using uv (recommended)
uv add outscraper-mcp

# Using uvx for one-time execution
uvx outscraper-mcp
```

### Manual Installation

```bash
git clone https://github.com/jayozer/outscraper-mcp
cd outscraper-mcp

# Using uv (recommended)
uv sync

# Using pip
pip install -e .
```

## 🔧 Configuration

### Get Your API Key
1. Sign up at [Outscraper](https://app.outscraper.com/profile)
2. Get your API key from the profile page

### Set Environment Variable
```bash
export OUTSCRAPER_API_KEY="your_api_key_here"
```

Or create a `.env` file:
```env
OUTSCRAPER_API_KEY=your_api_key_here
```

## 🛠️ Client Configuration

### Claude Desktop

Add to your `claude_desktop_config.json`:

**Via Smithery (Automatic):**
```json
{
  "mcpServers": {
    "outscraper": {
      "command": "npx",
      "args": ["-y", "@smithery/cli", "run", "outscraper-mcp"],
      "env": {
        "OUTSCRAPER_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

**Via Local Installation:**
```json
{
  "mcpServers": {
    "outscraper": {
      "command": "uvx",
      "args": ["outscraper-mcp"],
      "env": {
        "OUTSCRAPER_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

**Via Manual Installation:**
```json
{
  "mcpServers": {
    "outscraper": {
      "command": "uv",
      "args": ["run", "python", "-m", "outscraper_mcp"],
      "env": {
        "OUTSCRAPER_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

### Cursor AI

**Automatic Installation with UVX (Recommended):**
```json
{
  "mcpServers": {
    "outscraper": {
      "command": "uvx",
      "args": ["outscraper-mcp"],
      "env": {
        "OUTSCRAPER_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

**Manual Installation:**
```json
{
  "mcpServers": {
    "outscraper": {
      "command": "outscraper-mcp",
      "env": {
        "OUTSCRAPER_API_KEY": "your_api_key_here"
      }
    }
  }
}
```

> **Note for Cursor Users**: The configuration file is typically located at:
> - **macOS**: `~/Library/Application Support/Cursor/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json`
> - **Windows**: `%APPDATA%\Cursor\User\globalStorage\saoudrizwan.claude-dev\settings\cline_mcp_settings.json`
> - **Linux**: `~/.config/Cursor/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json`

## 🛠️ Tools Reference

### google_maps_search
Search for businesses and places on Google Maps
```python
# Parameters:
query: str              # Search query (e.g., 'restaurants brooklyn usa')
limit: int = 20         # Number of results (max: 400)
language: str = "en"    # Language code
region: str = None      # Country/region code (e.g., 'US', 'GB')
drop_duplicates: bool = False  # Remove duplicate results
enrichment: List[str] = None   # Additional services ['domains_service', 'emails_validator_service']
```

### google_maps_reviews
Extract reviews from Google Maps places
```python
# Parameters:
query: str              # Place query, place ID, or business name
reviews_limit: int = 10 # Number of reviews per place (0 for unlimited)
limit: int = 1          # Number of places to process
sort: str = "most_relevant"  # Sort order: 'most_relevant', 'newest', 'highest_rating', 'lowest_rating'
language: str = "en"    # Language code
region: str = None      # Country/region code
cutoff: int = None      # Unix timestamp for reviews after specific date
```

## 🚀 Running the Server

### Development & Testing
```bash
# FastMCP Inspector - Web-based testing dashboard
fastmcp dev outscraper_mcp/server.py

# Then open your browser to: http://127.0.0.1:6274
# Interactive testing of Google Maps tools with real-time responses
```

### Stdio Transport (Default)
```bash
# Via PyPI installation
outscraper-mcp

# Via uv
uv run python -m outscraper_mcp

# Via manual installation
python -m outscraper_mcp
```

### HTTP Transport
```python
from outscraper_mcp import mcp

if __name__ == "__main__":
    mcp.run(transport="streamable-http", host="127.0.0.1", port=8000)
```

## 💡 Usage Examples

### Example 1: Find Restaurants and Get Reviews
```python
# 1. Search for restaurants
results = google_maps_search(
    query="italian restaurants manhattan nyc",
    limit=5,
    language="en",
    region="US"
)

# 2. Get reviews for a specific place
reviews = google_maps_reviews(
    query="ChIJrc9T9fpYwokRdvjYRHT8nI4",  # Place ID from search results
    reviews_limit=20,
    sort="newest"
)
```

### Example 2: Lead Generation with Enrichment
```python
# Find businesses with enhanced contact information
businesses = google_maps_search(
    query="digital marketing agencies chicago",
    limit=20,
    enrichment=["domains_service", "emails_validator_service"]
)

# Get detailed reviews for sentiment analysis
for business in businesses:
    if business.get('place_id'):
        reviews = google_maps_reviews(
            query=business['place_id'],
            reviews_limit=10,
            sort="newest"
        )
```

### Example 3: Market Research
```python
# Research competitors in specific area
competitors = google_maps_search(
    query="coffee shops downtown portland",
    limit=50,
    region="US"
)

# Analyze recent customer feedback
recent_reviews = google_maps_reviews(
    query="coffee shops downtown portland",
    reviews_limit=100,
    sort="newest"
)
```

## 🔄 Integration with MCP Clients

This server is compatible with any MCP client, including:
- [Claude Desktop](https://claude.ai/desktop)
- [Cursor AI](https://cursor.sh)
- [Raycast](https://raycast.com)
- [VS Code](https://code.visualstudio.com) with MCP extensions
- Custom MCP clients

## 📊 Rate Limits & Pricing

- Check [Outscraper Pricing](https://outscraper.com/pricing/) for current rates
- API key usage is tracked per request
- Consider implementing caching for frequently accessed data

## 🐛 Troubleshooting

### Common Issues

1. **Import Error**: Make sure you've installed the package correctly
   ```bash
   pip install --upgrade outscraper-mcp
   ```

2. **API Key Error**: Verify your API key is set correctly
   ```bash
   echo $OUTSCRAPER_API_KEY
   ```

3. **No Results**: Check if your query parameters are valid

4. **Rate Limits**: Implement delays between requests if needed

### Enable Debug Logging
```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

Experimental Software License - see LICENSE file for details.

**Notice:** This software is experimental and free to use for all purposes. Created by Jay Ozer.

## 🔗 Links

- [Outscraper API Documentation](https://app.outscraper.com/api-docs)
- [FastMCP Documentation](https://gofastmcp.com)
- [Model Context Protocol](https://modelcontextprotocol.io)
- [Smithery Registry](https://smithery.ai)

---

**Built with Blu Goldens**