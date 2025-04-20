import { HMRouter } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';
import { ChatInputView } from '../widget/ChatInputView';
import { SafeAreaLayout } from '../widget/SafeAreaLayout';
import { LengthMetrics } from '@kit.ArkUI';

@HMRouter({ pageUrl: PageConstant.PAGE_HOME })
@ComponentV2
export struct HomePage {
  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        this.TitleBar()

        Column({
          space: 30
        }) {
          Text("InsightBox 激发你的创作灵感")
            .fontSize($r('app.float.font_size_title'))
            .fontWeight(FontWeight.Bold)
            .padding({
              start: LengthMetrics.vp(16),
              end: LengthMetrics.vp(16),
            })

          ChatInputView()
            .padding({
              start: LengthMetrics.vp(16),
              end: LengthMetrics.vp(16),
            })
        }
        .id('center')
        .alignRules({
          middle: {
            align: HorizontalAlign.Center,
            anchor: '__container__',
          },
          center: {
            align: VerticalAlign.Center,
            anchor: '__container__',
          },
        })
      }
      .height('100%')
      .width('100%')
    }
  }

  aboutToAppear(): void {
  }

  /**
   * 标题栏
   */
  @Builder
  TitleBar() {
    RelativeContainer() {
      Text($r('app.string.app_name'))
        .fontWeight(FontWeight.Bold)
        .fontSize($r('app.float.font_size_title'))
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
    .height($r('app.float.title_bar_height'))
  }
}