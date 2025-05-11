import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import { PageConstant } from '../constant/PageConstant'
import { CommonTitleBar } from '../widget/CommonTitleBar'
import { SafeAreaLayout } from '../widget/SafeAreaLayout'
import { LengthMetrics } from '@kit.ArkUI'
import { ModelAddAndEditPageParam } from './ModelAddAndEditPage'

/**
 * 模型设置页面
 */
@HMRouter({ pageUrl: PageConstant.PAGE_MODEL_LIST })
@ComponentV2
export struct ModelListPage {
  // 用户已配置的数据列表

  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        CommonTitleBar({
          title: $r('app.string.llm_set'),
          onBackClick: () => {
            HMRouterMgr.pop()
          }
        })

        // 添加
        Image($r('app.media.icon_svg_add'))
          .width(48)
          .fillColor(Color.White)
          .padding(14)
          .shadow(ShadowStyle.OUTER_FLOATING_SM)
          .borderRadius(24)
          .onClick(() => {
            // 临时跳转
            HMRouterMgr.push({
              pageUrl: PageConstant.PAGE_MODEL_ADD_EDIT,
              param: {
                type: 'add'
              } as ModelAddAndEditPageParam
            })
          })
          .stateStyles({
            normal: this.normalStyles,
            pressed: this.pressedStyles
          })
          .backgroundColor(Color.Black)
          .alignRules({
            bottom: {
              anchor: "__container__",
              align: VerticalAlign.Bottom
            },
            end: {
              anchor: "__container__",
              align: HorizontalAlign.End
            }
          })
          .margin({
            bottom: LengthMetrics.vp(20),
            end: LengthMetrics.vp(20)
          })

        List() {

        }
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