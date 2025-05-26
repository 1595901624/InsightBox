import { HMLifecycleState, HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import { PageConstant } from '../constant/PageConstant'
import { CommonTitleBar } from '../widget/CommonTitleBar'
import { SafeAreaLayout } from '../widget/SafeAreaLayout'
import { LengthMetrics } from '@kit.ArkUI'
import { ModelAddAndEditPageParam } from './ModelAddAndEditPage'
import { LLMUserConfig } from '../db/entity/LLMUserConfig'
import { LLMUserConfigTBUtil } from '../db/LLMUserConfigTBUtil'
import { log } from '../util/LogUtil'

/**
 * 模型设置页面
 */
@HMRouter({ pageUrl: PageConstant.PAGE_MODEL_LIST })
@ComponentV2
export struct ModelListPage {
  // 用户已配置的数据列表
  // @Local private viewModel: ModelListPageLifeCycle | undefined =
  //   (HMRouterMgr.getCurrentLifecycleOwner()?.getLifecycle() as ModelListPageLifeCycle | undefined)
  @Local private llmUserConfigList: LLMUserConfig[] = []

  aboutToAppear(): void {
    HMRouterMgr.getCurrentLifecycleOwner()?.addObserver(HMLifecycleState.onShown, this.onPageShow)
  }

  aboutToDisappear(): void {
    HMRouterMgr.getCurrentLifecycleOwner()?.removeObserver(HMLifecycleState.onShown, this.onPageShow)
  }

  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        CommonTitleBar({
          title: $r('app.string.llm_set'),
          onBackClick: () => {
            HMRouterMgr.pop()
          }
        })
          .id('title_bar')


        List() {
          ForEach(this.llmUserConfigList ?? [], (item: LLMUserConfig, index: number) => {
            ListItem() {
              // Text(item.id + '--' + item.brandName)
              Row() {
                Button() {
                  Row() {
                    Text(item.alias + '(' + item.brandName + ')')
                      .fontSize(16)
                      .textAlign(TextAlign.Start)
                      .maxLines(1)
                    Blank()
                    Toggle({
                      isOn: item.enable == 1,
                      type: ToggleType.Switch
                    })
                      .onChange((isOn: boolean) => {
                        // 更新数据
                        item.enable = isOn ? 1 : 0
                        LLMUserConfigTBUtil.getInstance().insertOrReplace(item)
                          .then(() => {
                            log.info('Update success:', JSON.stringify(item, null, 2));
                          })
                          .catch((error: Error) => {
                            log.error('Error updating data:', error);
                          });
                      })
                  }
                  .width("100%")
                  .padding({
                    start: LengthMetrics.vp(20),
                    end: LengthMetrics.vp(20)
                  })
                }
                .type(ButtonType.Normal)
                .borderRadius(8)
                .backgroundColor(Color.Transparent)
                .height(60)
                .width("100%")
              }
              .backgroundColor(Color.White)
              .alignItems(VerticalAlign.Center)
              .borderRadius(8)
              .onClick(() => {
                // 跳转到编辑页面
                HMRouterMgr.push({
                  pageUrl: PageConstant.PAGE_MODEL_ADD_EDIT,
                  param: {
                    type: 'edit',
                    brandId: item.brandId,
                    editConfig: item,
                  } as ModelAddAndEditPageParam
                })
              })
            }
            .swipeAction({
              end: {
                // index为该ListItem在List中的索引值。
                builder: () => {
                  this.ListItemEnd(item, index)
                },
              }
            }) // 设置侧滑属性.
            .padding({
              start: LengthMetrics.vp(20),
              end: LengthMetrics.vp(20)
            })
          })
        }
        .scrollBar(BarState.Off)
        .divider({
          strokeWidth: 8,
          color: Color.Transparent
        })
        .alignRules({
          top: {
            anchor: "title_bar",
            align: VerticalAlign.Bottom
          },
          bottom: {
            anchor: "__container__",
            align: VerticalAlign.Bottom
          },
        })

        // 添加
        Image($r('app.media.icon_svg_add'))
          .width(48)
          .fillColor(Color.White)
          .padding(14)
          .shadow(ShadowStyle.OUTER_FLOATING_SM)
          .borderRadius(24)
          .onClick(() => {
            // HMRouterMgr.push({
            //   pageUrl: PageConstant.PAGE_MODEL_ADD_EDIT,
            //   param: {
            //     type: 'add'
            //   } as ModelAddAndEditPageParam
            // })
            HMRouterMgr.push({
              pageUrl: PageConstant.PAGE_MODEL_PROVIDER,
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
      }
    }
  }

  @Builder
  ListItemEnd(llmUserConfig: LLMUserConfig, index: number) {
    // 构建尾端滑出组件
    Button({ type: ButtonType.Circle }) {
      Image($r("app.media.icon_svg_trash"))
        .width(30)
        .height(30)
    }
    .margin({
      start: LengthMetrics.vp(8)
    })
    .onClick(() => {
      this.llmUserConfigList.splice(index, 1);
      LLMUserConfigTBUtil.getInstance().delete(llmUserConfig.id ?? -1)
        .then(() => {
          log.info('Delete success:', JSON.stringify(this.llmUserConfigList, null, 2));
        })
        .catch((error: Error) => {
          log.error('Error deleting data:', error);
        });
    })
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

  @Styles
  normalStyles(): void {
    .opacity(1)
  }

  @Styles
  pressedStyles(): void {
    .opacity(0.5)
  }
}