import { LengthMetrics } from '@kit.ArkUI'

@ComponentV2
export struct CommonTitleBar {
  @Param title: ResourceStr = ""
  @Event onBackClick?: () => void

  build() {
    RelativeContainer() {
      Image($r('app.media.icon_svg_back'))
        .width(20)
        .height(20)
        .fillColor(Color.Black)
        .onClick(() => {
          this.onBackClick?.()
        })
        .margin({
          start: LengthMetrics.vp(16)
        })
        .alignRules({
          center: {
            align: VerticalAlign.Center,
            anchor: '__container__',
          },
        })

      Text(this.title)
        .fontWeight(FontWeight.Bold)
        .fontSize($r('app.float.font_size_title'))
        .id('title')
        .alignRules({
          center: {
            align: VerticalAlign.Center,
            anchor: '__container__',
          },
          middle: {
            align: HorizontalAlign.Center,
            anchor: '__container__',
          },
        })
    }
    .id('title_bar')
    .height($r('app.float.title_bar_height'))
  }
}