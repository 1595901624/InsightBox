import { LLMConfig } from './LLMConfig';

export class LLMUserConfig {
  brandId?: number;
  brandName?: string;
  baseUrl?: string;
  apiKey?: string;
  modelList?: LLMUserModelGroup[];
}


export class LLMUserModelGroup {
  enable?: boolean;
  name?: string;
  value?: LLMUserModelItem[];
}

export class LLMUserModelItem {
  id?: string;
  type?: LLMConfig.ModelType;
  name?: string;
  enabled?: boolean;
}