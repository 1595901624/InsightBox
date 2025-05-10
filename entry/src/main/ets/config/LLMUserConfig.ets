export class LLMUserConfig {
  brandId?: number;
  brandName?: string;
  baseUrl?: string;
  apiKey?: string;
  modelList?: LLMUserModel[];
}


export class LLMUserModel {
  enable?: boolean;
  name?: string;
  id?: string;
  group?: string;
}