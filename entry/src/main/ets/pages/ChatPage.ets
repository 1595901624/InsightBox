import { HMRouter } from '@hadss/hmrouter';
import { ChatItemComponent } from '../component/ChatItemComponent';
import { PageConstant } from '../constant/PageConstant';
import { ChatDataSource } from '../datasource/ChatDataSource';
import { ChatMessage } from '../model/ChatMessage';
import { ChatInputView } from '../widget/ChatInputView';
import { SafeAreaLayout } from '../widget/SafeAreaLayout';
import { LengthMetrics } from '@kit.ArkUI';
import { SSEGateway } from '../http/gateway/SSEGateway';

@HMRouter({ pageUrl: PageConstant.PAGE_CHAT })
@ComponentV2
export struct ChatPage {
  private dataSource: ChatDataSource = new ChatDataSource();
  private sseGateway: SSEGateway = new SSEGateway();
  @Local private showSideBar: boolean = false;

  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        this.TitleBar()

        Column() {
          List() {
            LazyForEach(this.dataSource, (item: ChatMessage, index: number) => {
              ListItem() {
                ChatItemComponent({
                  message: item,
                })
              }
            }, (item: ChatMessage, index: number) => {
              return JSON.stringify(item) + index
            })
          }
          .scrollBar(BarState.Off)
          .divider({
            color: Color.Transparent,
            strokeWidth: 10,
          })
        }
        .justifyContent(FlexAlign.End)
        .padding({
          start: LengthMetrics.vp(16),
          end: LengthMetrics.vp(16),
        })
        .alignRules({
          top: {
            align: VerticalAlign.Bottom,
            anchor: 'title_bar',
          },
          bottom: {
            align: VerticalAlign.Top,
            anchor: 'chat_input',
          }
        })

        ChatInputView({
          onSendClick: (msg: string) => {
            this.dataSource.addUserMessage(msg)
            this.dataSource.addAssistantMessage('正在生成中...')
          }
        })
          .id('chat_input')
          .padding({
            start: LengthMetrics.vp(16),
            end: LengthMetrics.vp(16)
          })
          .alignRules({
            bottom: {
              align: VerticalAlign.Bottom,
              anchor: '__container__',
            },
          })

        this.SideBar()
      }
      .width("100%")
      .height("100%")
    }
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
    .id('title_bar')
    .height($r('app.float.title_bar_height'))
  }

  @Builder
  SideBar() {
    
  }
}