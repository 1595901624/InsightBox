import { HMLifecycleState, HMRouter, HMRouterMgr } from '@hadss/hmrouter';
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
import { DrawerLayout, DrawerLayoutController } from '@cloris/drawerlayout';
import { ChatStatus } from '../model/ChatStatus';
import { ChatMessageType } from '../model/ChatMessageType';
import { stringUtil } from '../util/StringUtil';
import { SideBottomComponent } from '../component/SideBottomComponent';
import { LLMUserConfig } from '../db/entity/LLMUserConfig';
import { LLMUserConfigTBUtil } from '../db/LLMUserConfigTBUtil';
import { log } from '../util/LogUtil';
import { LLMConfig } from '../config/LLMConfig';

@HMRouter({ pageUrl: PageConstant.PAGE_CHAT })
@ComponentV2
export struct ChatPage {
  // 模型名称
  @Local private modelName: ResourceStr = $r('app.string.app_name')
  private scroller = new ListScroller()
  private dataSource: ChatDataSource = new ChatDataSource();
  private sseGateway: SSEGateway = new SSEGateway();
  private responseMsg: string = ""
  private drawerLayoutController: DrawerLayoutController = new DrawerLayoutController()
  // 聊天状态
  private chatStatus: ChatStatus = ChatStatus.Ready
  // 用户配置列表
  @Local private llmUserConfigList: LLMUserConfig[] = []

  aboutToAppear(): void {
    HMRouterMgr.getCurrentLifecycleOwner()?.addObserver(HMLifecycleState.onShown, this.onPageShow)
    this.sseGateway.setListener(this.sseListener)
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
    // this.onPageShow()
  }

  aboutToDisappear(): void {
    HMRouterMgr.getCurrentLifecycleOwner()?.removeObserver(HMLifecycleState.onShown, this.onPageShow)
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.OFFSET);
  }

  build() {
    SafeAreaLayout() {
      DrawerLayout({
        controller: this.drawerLayoutController,
        mainContent: () => {
          this.MainContent()
        },
        navContent: () => {
          this.NavContent()
        },
        onMaskClick: () => {
          this.drawerLayoutController.closeDrawer()
        },
        onProgressChange: (progress: number) => {

        }
      })
    }
  }

  onPageShow = () => {
    LLMUserConfigTBUtil.getInstance().queryAll()
      .then((llmUserConfigList) => {
        this.llmUserConfigList = llmUserConfigList;
        // 处理查询结果
        log.info('Query result:', JSON.stringify(llmUserConfigList, null, 2));
      })
      .catch((error: Error) => {
        // 处理错误
        log.error('Error querying data:', error);
      });
  }

  /**
   * 主布局
   */
  @Builder
  MainContent() {
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

  /**
   * 抽屉布局
   */
  @Builder
  NavContent() {
    RelativeContainer() {
      // Text("抽屉布局")
      //   .fontSize($r('app.float.font_size_title'))
      //   .fontWeight(FontWeight.Bold)
      //   .padding({
      //     start: LengthMetrics.vp(16),
      //     end: LengthMetrics.vp(16),
      //   })
      SideBottomComponent({
        drawerLayoutController: this.drawerLayoutController,
      })
        .id('side_bottom')
        .alignRules({
          bottom: {
            align: VerticalAlign.Bottom,
            anchor: '__container__',
          },
          start: {
            align: HorizontalAlign.Start,
            anchor: '__container__',
          },
        })
    }
    .backgroundColor($r('app.color.background'))
    .height('100%')
    .width('100%')
  }

  /**
   * 标题栏
   */
  @Builder
  TitleBar() {
    RelativeContainer() {
      Image($r('app.media.icon_svg_menu'))
        .width(20)
        .height(20)
        .fillColor(Color.Black)
        .onClick(() => {
          this.drawerLayoutController.openDrawer()
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
        .bindMenu(this.ModelSelectMenu)

      Image($r("app.media.icon_svg_arrow_end"))
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

  @Builder
  ModelSelectMenu() {
    Menu() {
      ForEach(this.llmUserConfigList, (item: LLMUserConfig, index: number) => {
        MenuItemGroup({
          header: item.alias + "(" + item.brandName + ")",
        }) {
          ForEach(this.getMenuModelItemList(item.modelList), (model: LLMConfig.ModelGroup, index: number) => {
            MenuItem({
              content: model.name,
            })
          })
        }
      })
    }
  }

  /**
   * 将所有分组的模型列表拆分为菜单项
   * @param group
   * @returns
   */
  getMenuModelItemList(group: LLMConfig.ModelGroup[] | undefined): LLMConfig.ModelItem[] {
    if (group === undefined) {
      return []
    }
    const modelList: LLMConfig.ModelItem[] = []
    group.forEach((item: LLMConfig.ModelGroup) => {
      item.value?.forEach((model: LLMConfig.ModelItem) => {
        modelList.push(model)
      })
    })
    return modelList
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
      this.chatStatus = ChatStatus.AssistantLoading
      this.dataSource.addAssistantMessage(stringUtil.getString($r('app.string.chat_assistant_loading')),
        ChatMessageType.Loading)
    },
    onChunkMessage: (chunk: LLMChunk) => {
      this.chatStatus = ChatStatus.AssistantGenerating
      const content = chunk?.choices?.[0]?.delta?.content ?? ""
      if (content.length > 0) {
        this.responseMsg += content
      }
      this.dataSource.updateAssistantMessage(this.responseMsg)
    },
    onComplete: () => {
      this.chatStatus = ChatStatus.Idle
      this.responseMsg = ""
    },
    // onMessage: (result: LLMResult) => {
    //   this.dataSource.updateAssistantMessage(result?.choices?.[0]?.message?.content ?? "")
    // }
  }
}