import { LengthMetrics } from '@kit.ArkUI'
import { SettingView } from '../widget/SettingView'

/**
 * 侧边栏下方的设置
 */
@ComponentV2
export struct SideBottomComponent {
  build() {
    Column() {
      // Button() {
      //   Text() {
      //     ImageSpan($r('app.media.icon_svg_set'))
      //       .height(18)
      //       .padding({
      //         end: LengthMetrics.vp(12)
      //       })
      //
      //     Span($r("app.string.set"))
      //       .fontSize(14)
      //       .fontColor(Color.Black)
      //   }
      // }
      // .type(ButtonType.Normal)
      // .backgroundColor(Color.Transparent)
      // .width("100%")
      // .align(Alignment.Start)
      // .padding({
      //   start: LengthMetrics.vp(24),
      //   end: LengthMetrics.vp(24),
      //   top: LengthMetrics.vp(8),
      //   bottom: LengthMetrics.vp(8)
      // })
      SettingView({
        title: $r("app.string.set"),
        icon: $r('app.media.icon_svg_set'),
        onSetClick: () => {

        },
      })
    }.width("100%")
    .alignItems(HorizontalAlign.Start)
    .padding({
      bottom: LengthMetrics.vp(24),
    })
  }
}