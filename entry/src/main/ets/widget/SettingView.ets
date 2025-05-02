import { LengthMetrics } from '@kit.ArkUI'

@ComponentV2
export struct SettingView {
  @Param title: ResourceStr = ""
  @Param icon: ResourceStr | PixelMap = ""
  @Event onSetClick?: () => void

  build() {
    Button() {
      Text() {
        ImageSpan(this.icon)
          .height(18)
          .padding({
            end: LengthMetrics.vp(12)
          })

        Span(this.title)
          .fontSize(14)
          .fontColor($r('app.color.set_text_color'))
      }
    }
    .onClick(() => {
      this.onSetClick?.()
    })
    .type(ButtonType.Normal)
    .backgroundColor(Color.Transparent)
    .width("100%")
    .align(Alignment.Start)
    .padding({
      start: LengthMetrics.vp(24),
      end: LengthMetrics.vp(24),
      top: LengthMetrics.vp(8),
      bottom: LengthMetrics.vp(8)
    })
  }
}