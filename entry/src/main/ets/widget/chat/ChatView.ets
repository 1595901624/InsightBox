import { AssistantItemComponent } from '../../component/AssistantItemComponent';
import { SystemItemComponent } from '../../component/SystemItemComponent';
import { UserItemComponent } from '../../component/UserItemComponent';
import { ChatDataSource } from '../../datasource/ChatDataSource';
import { BaseChatMessage } from './mode/BaseChatMessage';
import { ChatRole } from '../../model/ChatRole';
import { LengthMetrics } from '@kit.ArkUI';

@ComponentV2
@Entry
@Preview
export struct ChatView {
  private dataSource: ChatDataSource = new ChatDataSource();
  private scroller: Scroller = new ListScroller();
  private count = 0

  aboutToAppear(): void {
    this.dataSource.pushList([{
      role: ChatRole.User,
      name: '张三',
      content: '你好'
    }, {
      role: ChatRole.System,
      content: '欢迎来到聊天室'
    }, {
      role: ChatRole.Assistant,
      content: '我是小助手'
    }])

    setInterval(() => {
      this.count += 1;
      if (this.count > 10) {
        return;
      }
      if (this.count % 2 != 0) {
        this.dataSource.pushList([{
          role: ChatRole.User,
          name: '张三',
          content: '你好'
        }])
      } else {
        this.dataSource.pushList([{
          role: ChatRole.Assistant,
          content: '我是小助手'
        }])
      }
      this.scroller.scrollToIndex(this.dataSource.totalCount() - 1, true);
      // this.dataSource.pushList([{
      //   role: ChatRole.User,
      //   name: '李四',
      //   content: '你好'
      // }, {
      //   role: ChatRole.System,
      //   content: '欢迎来到聊天室'
      // }, {
      //   role: ChatRole.Assistant,
      //   content: '我是小助手'
      // }])
    }, 3000)
  }

  build() {
    List({
      scroller: this.scroller,
      space: 8,
    }) {
      LazyForEach(this.dataSource, (data: BaseChatMessage, index: number) => {
        ListItem() {
          if (data.role == ChatRole.User) {
            UserItemComponent();
          } else if (data.role == ChatRole.System) {
            SystemItemComponent();
          } else if (data.role == ChatRole.Assistant) {
            AssistantItemComponent();
          }
        }
        .padding({
          start: LengthMetrics.vp(16),
          end: LengthMetrics.vp(16),
        })
      })
    }
  }
}