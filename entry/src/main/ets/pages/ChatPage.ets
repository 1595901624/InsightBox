import { HMRouter } from '@hadss/hmrouter';
import { ChatItemComponent } from '../component/ChatItemComponent';
import { PageConstant } from '../constant/PageConstant';
import { ChatDataSource } from '../datasource/ChatDataSource';
import { ChatMessage } from '../model/ChatMessage';
import { ChatInputView } from '../widget/ChatInputView';
import { SafeAreaLayout } from '../widget/SafeAreaLayout';
import { LengthMetrics } from '@kit.ArkUI';

@HMRouter({ pageUrl: PageConstant.PAGE_CHAT })
@ComponentV2
export struct ChatPage {
  private dataSource: ChatDataSource = new ChatDataSource();

  build() {
    SafeAreaLayout() {
      RelativeContainer() {

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
        .alignRules({
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
      }
      .width("100%")
      .height("100%")
    }
  }
}