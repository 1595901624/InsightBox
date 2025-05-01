# InsightBox

## LLM Configuration

The LLM configuration JSON structure defines available language model providers and their configuration options.

### OpenAI Configuration

```json
[
  {
    "brand": "OpenAI",
    "properties": {
      "apikey": {
        "title": "%apikey.title%",
        "description": "%apikey.description%",
        "default": "",
        "url": "https://platform.openai.com/api-keys"
      },
      "baseUrl": {
        "title": "%baseUrl.title%",
        "description": "%baseUrl.description%",
        "default": "https://api.openai.com/v1"
      },
      "model": {
        "title": "%model.title%",
        "description": "%model.description%",
        "enum": [
          {
            "id": "gpt-3.5-turbo",
            "name": "gpt-3.5",
            "type": 1,
            "description": "%model.gpt-3.5.description%",
            "created": true
          }
        ]
      }
    }
  }
]
```

### Configuration Details

#### Brand
- `brand`: Identifies the LLM provider (OpenAI in this case).

#### Properties

##### API Key
- `apikey.title`: Display name for the API key field
- `apikey.description`: Helper text explaining the API key
- `default`: Empty by default, requires user input
- `url`: Direct link to OpenAI's API key management page

##### Base URL
- `baseUrl.title`: Display name for the API endpoint URL
- `baseUrl.description`: Helper text explaining the base URL
- `default`: The standard OpenAI API endpoint

##### Model Selection
- `model.title`: Display name for model selection
- `model.description`: Helper text explaining model options
- `enum`: List of available models with the following properties:
  - `id`: Unique identifier used for API calls (e.g., "gpt-3.5-turbo")
  - `name`: Display name shown in UI (e.g., "gpt-3.5")
  - `type`: Model type identifier (1 for chat models)
  - `description`: Localized description of the model capabilities
  - `created`: Boolean indicating if model is ready for use

### Localization

The configuration uses string placeholders (e.g., `%apikey.title%`) that should be replaced with localized text through the application's translation system.
