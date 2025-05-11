import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import { LLMConfig } from '../config/LLMConfig'
import { LLMConfigUtil } from '../config/LLMConfigUtil'
import { PageConstant } from '../constant/PageConstant'
import { log } from '../util/LogUtil'
import { CommonTitleBar } from '../widget/CommonTitleBar'
import { SafeAreaLayout } from '../widget/SafeAreaLayout'
import { LengthMetrics } from '@kit.ArkUI'
import { ModelConfigDataSource } from '../datasource/ModelConfigDataSource'


export interface ModelAddAndEditPageParam {
  /**
   * 模型新增或者编辑
   */
  type: 'add' | 'edit',

  /**
   * 新增或者编辑的品牌id
   */
  brandId?: number,
}

/**
 * 模型新增或者编辑页面
 */
@HMRouter({ pageUrl: PageConstant.PAGE_MODEL_ADD_EDIT })
@ComponentV2
export struct ModelAddAndEditPage {
  @Local type: 'add' | 'edit' = 'add'
  private brandId: number = 0
  // 当前添加或者编辑的模型配置
  @Local private config: LLMConfig.Config | undefined = undefined
  // 模型的 baseUrl
  @Local private baseUrl: string = ""
  // 模型列表数据源
  @Local private modelListChatDataSource: ModelConfigDataSource = new ModelConfigDataSource()

  aboutToAppear(): void {
    const param = HMRouterMgr.getCurrentParam() as ModelAddAndEditPageParam
    if (param == undefined) {
      HMRouterMgr.pop()
      log.error('ModelAddAndEditPage: aboutToAppear, param is undefined')
      return
    }
    this.type = param.type ?? 'add'
    this.brandId = param.brandId ?? 0
    if (this.brandId === -1) {
      // 如果没有品牌id，说明是错误的跳转
      log.error(`ModelAddAndEditPage: aboutToAppear, brandId is -1, type: ${this.type}`)
      HMRouterMgr.pop()
      return
    }
    this.config = LLMConfigUtil.getInstance().getConfigById(this.brandId)
    if (this.config === undefined) {
      // 如果没有找到配置，说明是错误的跳转
      log.error(`ModelAddAndEditPage: aboutToAppear, config is undefined, brandId: ${this.brandId}`)
      HMRouterMgr.pop()
      return
    }
    this.baseUrl = this.config?.properties?.baseUrl?.default ?? ""
    this.modelListChatDataSource.pushList(this.config?.properties?.model?.list ?? [])
  }

  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        CommonTitleBar({
          title: this.type === 'add' ? $r('app.string.llm_add') : $r('app.string.llm_edit'),
          endText: $r('app.string.llm_save'),
          endTextEnable: true,
          onEndTextClick: () => {

          },
          onBackClick: () => {
            HMRouterMgr.pop()
          }
        })
          .id('title_bar')

        // 添加或者编辑的模型配置
        Column({
          space: 16
        }) {
          Text(this.type === 'add' ? $r('app.string.llm_add_any', this.config?.brand ?? "") :
          $r('app.string.llm_edit_any', this.config?.brand ?? ""))
            .fontSize($r('app.float.font_size_subtitle'))
            .fontWeight(FontWeight.Bold)

          // API 地址
          if (this.config?.properties?.baseUrl != undefined) {
            Column({
              space: 8
            }) {
              Text($r('app.string.llm_base_url'))
                .fontSize($r('app.float.font_size_subtitle'))

              TextInput({
                text: $$this.baseUrl,
                placeholder: $r('app.string.llm_base_url_hint'),
              }).width("100%")
                .borderRadius(8)

              Text(this.getRealBaseUrl())
                .fontSize($r('app.float.font_size_label'))
                .fontColor($r('app.color.desc_text_color'))

            }.alignItems(HorizontalAlign.Start)
            .width("100%")
          }

          // API Key
          if (this.config?.properties?.apikey != undefined) {
            Column({
              space: 8
            }) {
              Text($r('app.string.llm_api_key'))
                .fontSize($r('app.float.font_size_subtitle'))

              TextInput({
                text: this.config?.properties?.apikey?.default,
                placeholder: $r('app.string.llm_api_key_hint'),
              }).width("100%")
                .borderRadius(8)
            }.alignItems(HorizontalAlign.Start)
            .width("100%")
          }

          // 模型列表
          if (this.config?.properties?.model != undefined) {
            Column({
              space: 8
            }) {
              Text($r('app.string.llm_model_list'))
                .fontSize($r('app.float.font_size_subtitle'))

              List() {
                LazyForEach(this.modelListChatDataSource, (groupItem: LLMConfig.ModelGroup) => {
                  ListItemGroup({
                    header: this.ModelGroupHeader(groupItem),
                  }) {
                    ForEach(groupItem.value, (modelItem: LLMConfig.ModelItem) => {
                      ListItem() {
                        Row() {
                          Text(modelItem.name)
                            .fontSize($r('app.float.font_size_subtitle'))
                            .fontWeight(FontWeight.Bold)
                          Blank()
                          Toggle({
                            isOn: modelItem.enabled,
                            type: ToggleType.Switch
                          })
                        }
                        .padding({
                          start: LengthMetrics.vp(16),
                          end: LengthMetrics.vp(16),
                          top: LengthMetrics.vp(16),
                          bottom: LengthMetrics.vp(16)
                        })
                        .borderRadius(8)
                        .backgroundColor($r('app.color.list_item_bg_color'))
                        .width("100%")
                      }.margin({
                        top: LengthMetrics.vp(4),
                        bottom: LengthMetrics.vp(4)
                      })
                    })
                  }
                })
              }
              .layoutWeight(1)
              .scrollBar(BarState.Off)
            }.alignItems(HorizontalAlign.Start)
            .width("100%")
          }
        }
        .padding({
          start: LengthMetrics.vp(16),
          end: LengthMetrics.vp(16),
        })
        .width("100%")
        .alignItems(HorizontalAlign.Start)
        .margin({
          top: LengthMetrics.vp(20),
          start: LengthMetrics.vp(16),
          end: LengthMetrics.vp(16)
        })
        .alignRules({
          top: {
            anchor: "title_bar",
            align: VerticalAlign.Bottom
          },
          start: {
            anchor: "__container__",
            align: HorizontalAlign.Start
          },
          end: {
            anchor: "__container__",
            align: HorizontalAlign.End
          }
        })
      }
    }
  }

  @Builder
  ModelGroupHeader(item: LLMConfig.ModelGroup) {
    Text(item.name ?? "")
      .fontSize($r('app.float.font_size_caption'))
      .padding({
        top: LengthMetrics.vp(2),
        bottom: LengthMetrics.vp(2)
      })
      .width("100%")
  }

  /**
   * 获取真实的 baseUrl
   * /结尾忽略v1版本，#结尾强制使用输入地址
   */
  getRealBaseUrl() {
    let realBaseUrl = ""
    if (this.baseUrl.endsWith("/")) {
      realBaseUrl = this.baseUrl.substring(0, this.baseUrl.length - 1) + "/chat/completions"
    } else if (this.baseUrl.endsWith("#")) {
      realBaseUrl = this.baseUrl.substring(0, this.baseUrl.length - 1)
    } else {
      realBaseUrl = this.baseUrl + "/v1/chat/completions"
    }
    return realBaseUrl
  }

  @Styles
  normalStyles(): void {
    .opacity(1)
  }

  @Styles
  pressedStyles(): void {
    .opacity(0.5)
  }
}