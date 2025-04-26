import { HMRouter } from '@hadss/hmrouter';
import { ChatItemComponent } from '../component/ChatItemComponent';
import { PageConstant } from '../constant/PageConstant';
import { ChatDataSource } from '../datasource/ChatDataSource';
import { ChatMessage } from '../model/ChatMessage';
import { ChatInputView } from '../widget/ChatInputView';
import { SafeAreaLayout } from '../widget/SafeAreaLayout';
import { KeyboardAvoidMode, LengthMetrics } from '@kit.ArkUI';
import { SSEGateway } from '../http/gateway/SSEGateway';
import { SSEListener } from '../http/gateway/SSEListener';
import { LLMChunk } from '../model/LLMChunk';

@HMRouter({ pageUrl: PageConstant.PAGE_CHAT })
@ComponentV2
export struct ChatPage {
  @Local private showSideBar: boolean = false;
  // 模型名称
  @Local private modelName: ResourceStr = $r('app.string.app_name')
  private scroller = new ListScroller()
  private dataSource: ChatDataSource = new ChatDataSource();
  private sseGateway: SSEGateway = new SSEGateway();
  private responseMsg: string = ""

  aboutToAppear(): void {
    this.sseGateway.setListener(this.sseListener)
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
  }

  aboutToDisappear(): void {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.OFFSET);
  }

  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        this.TitleBar()

        Column() {
          List({
            scroller: this.scroller
          }) {
            LazyForEach(this.dataSource, (item: ChatMessage, index: number) => {
              ListItem() {
                ChatItemComponent({
                  message: item,
                })
              }
              .onSizeChange((_oldValue, newValue) => {
                if (!this.dataSource.isLastMessage(index)) {
                  return
                }
                // 自动滚动到底部
                if (newValue.height && newValue.height > 0) {
                  this.scroller.scrollEdge(Edge.Bottom)
                }
              })
            }, (item: ChatMessage, index: number) => {
              return JSON.stringify(item) + index
            })

          }
          .scrollBar(BarState.Off)
          .divider({
            color: Color.Transparent,
            strokeWidth: 16,
          })
        }
        .justifyContent(FlexAlign.End)
        .padding({
          start: LengthMetrics.vp(16),
          end: LengthMetrics.vp(16),
        })
        .margin({
          bottom: LengthMetrics.vp(16)
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
            this.sendMessage(msg)
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
      Text(this.modelName)
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

      Image($r('app.media.icon_arrow_end'))
        .width(16)
        .height(16)
        .margin({
          start: LengthMetrics.vp(2)
        })
        .alignRules({
          start: {
            align: HorizontalAlign.End,
            anchor: 'title',
          },
          center: {
            align: VerticalAlign.Center,
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

  private sendMessage(msg: string) {
    this.dataSource.addUserMessage(msg)
    this.sseGateway.postStreamRequest("http://xxxxxxxx:3000/v1/chat/completions", this.dataSource.getContextMessage())
  }

  /**
   * SSE 监听器
   */
  private sseListener: SSEListener = {
    onStart: () => {
      this.dataSource.addAssistantMessage("")
    },
    onChunkMessage: (chunk: LLMChunk) => {
      const content = chunk?.choices?.[0]?.delta?.content ?? ""
      if (content.length > 0) {
        this.responseMsg += content
      }
      this.dataSource.updateAssistantMessage(this.responseMsg)
    },
    onComplete: () => {
      this.responseMsg = ""
    },
    // onMessage: (result: LLMResult) => {
    //   this.dataSource.updateAssistantMessage(result?.choices?.[0]?.message?.content ?? "")
    // }
  }
}