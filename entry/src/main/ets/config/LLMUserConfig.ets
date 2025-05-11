import { LLMConfig } from './LLMConfig';

@ObservedV2
export class LLMUserConfig {
  /**
   * 配置id(唯一)
   */
  id: string = "";
  brandId?: number;
  brandName?: string;
  baseUrl?: string;
  apiKey?: string;
  modelList?: LLMUserModelGroup[];
}


@ObservedV2
export class LLMUserModelGroup {
  name?: string;
  value?: LLMUserModelItem[];
}

@ObservedV2
export class LLMUserModelItem {
  id?: string;
  type?: LLMConfig.ModelType;
  name?: string;
  enabled?: boolean;
}