import { Columns, ColumnType, Convert, Entity, Id, PropertyConverter } from '@ohos/dataorm';
import { LLMConfig } from '../../config/LLMConfig';

export class ModelListTypeConvert extends PropertyConverter<LLMUserModelGroup[], String> {
  convertToDatabaseValue(entityProperty: LLMUserModelGroup[]): string {
    return JSON.stringify(entityProperty)
  }

  convertToEntityProperty(databaseValue: string): LLMUserModelGroup[] {
    return JSON.parse(databaseValue)
  }
}

@Entity("LLMUserConfig")
export class LLMUserConfig {
  /**
   * 配置id(唯一)
   */
  @Id()
  @Columns({
    columnName: "id",
    types: ColumnType.num,
  })
  id?: number;
  /**
   * LLM 的品牌id
   */
  @Columns({
    columnName: "brandId",
    types: ColumnType.num,
  })
  brandId?: number;
  /**
   * LLM 的品牌名称
   */
  @Columns({
    columnName: "brandName",
    types: ColumnType.str,
  })
  brandName?: string;
  /**
   * LLM BaseUrl
   */
  @Columns({
    columnName: "baseUrl",
    types: ColumnType.str,
  })
  baseUrl?: string;
  /**
   * LLM apiKey
   */
  @Columns({
    columnName: "apiKey",
    types: ColumnType.str,
  })
  apiKey?: string;
  /**
   * LLM 模型列表
   */

  @Convert({ converter: ModelListTypeConvert, columnType: ColumnType.str })
  modelList?: LLMUserModelGroup[];

  constructor(
    id?: number,
    brandId?: number,
    brandName?: string,
    baseUrl?: string,
    apiKey?: string,
  ) {
    this.id = id;
    this.brandId = brandId;
    this.brandName = brandName;
    this.baseUrl = baseUrl;
    this.apiKey = apiKey;
  }
}

export class LLMUserModelGroup {
  name?: string;
  value?: LLMUserModelItem[];
}

export class LLMUserModelItem {
  id?: string;
  type?: LLMConfig.ModelType;
  name?: string;
  enabled?: boolean;
}