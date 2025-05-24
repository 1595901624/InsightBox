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
    HMRouterMgr.getCurrentLifecycleOwner()?.addObserver(HMLifecycleState.onShown, () => {
      this.onPageShow()
    })
  }

  aboutToDisappear(): void {
    HMRouterMgr.getCurrentLifecycleOwner()?.removeObserver(HMLifecycleState.onShown)
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
          ForEach(this.llmUserConfigList ?? [], (item: LLMUserConfig) => {
            ListItem() {
              // Text(item.id + '--' + item.brandName)
              Row() {
                Button() {
                  Text(item.alias + '(' + item.brandName + ')')
                    .fontSize(16)
                    .width("100%")
                    .textAlign(TextAlign.Start)
                    .maxLines(1)
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
            // 临时跳转
            HMRouterMgr.push({
              pageUrl: PageConstant.PAGE_MODEL_ADD_EDIT,
              param: {
                type: 'add'
              } as ModelAddAndEditPageParam
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

  onPageShow(): void {
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