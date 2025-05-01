# InsightBox

## LLM 配置

LLM配置的JSON结构定义了可用的语言模型提供商及其配置选项。

### OpenAI 配置

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

### 配置详情

#### 品牌

- `brand`: 标识LLM提供商（本例中为OpenAI）。

#### 属性

##### API密钥

- `apikey.title`: API密钥字段的显示名称
- `apikey.description`: 解释API密钥的帮助文本
- `default`: 默认为空，需要用户输入
- `url`: 获取API密钥管理页面的直接链接

##### 基础URL

- `baseUrl.title`: API端点URL的显示名称
- `baseUrl.description`: 解释基础URL的帮助文本
- `default`: 标准OpenAI API端点

##### 模型选择

- `model.title`: 模型选择的显示名称
- `model.description`: 解释模型选项的帮助文本
- `enum`: 可用模型列表，具有以下属性：
    - `id`: 用于API调用的唯一标识符（例如，"gpt-3.5-turbo"）
    - `name`: UI中显示的名称（例如，"gpt-3.5"）
    - `type`: 模型类型标识符（聊天模型为1）
    - `description`: 模型功能的本地化描述
    - `created`: 布尔值，表示模型是否在创建时默认添加

### 本地化

配置使用字符串占位符（例如，`%apikey.title%`），应通过应用程序的翻译系统替换为本地化文本。
