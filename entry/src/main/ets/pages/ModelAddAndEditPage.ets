import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import { LLMConfig } from '../config/LLMConfig'
import { LLMConfigUtil } from '../config/LLMConfigUtil'
import { PageConstant } from '../constant/PageConstant'
import { log } from '../util/LogUtil'
import { CommonTitleBar } from '../widget/CommonTitleBar'
import { SafeAreaLayout } from '../widget/SafeAreaLayout'
import { LengthMetrics } from '@kit.ArkUI'


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
        Column() {
          Text(this.type === 'add' ? $r('app.string.llm_add_any', this.config?.brand ?? "") :
          $r('app.string.llm_edit_any', this.config?.brand ?? ""))
            .fontSize($r('app.float.font_size_subtitle'))
            .fontWeight(FontWeight.Bold)

          // Column({
          //   space: 8
          // }) {
          //   Text("API 地址")
          //     .fontSize($r('app.float.font_size_subtitle'))
          //
          //   TextInput({
          //     placeholder: "请输入API地址",
          //   }).width("100%")
          //
          //   Text("/结尾忽略v1版本，#结尾强制使用输入地址")
          //     .fontSize($r('app.float.font_size_label'))
          //     .fontColor(Color.Gray)
          //
          // }.alignItems(HorizontalAlign.Start)
          // .width("100%")
        }
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
          }
        })
      }
    }
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