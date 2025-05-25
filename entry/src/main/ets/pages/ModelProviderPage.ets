import { CommonTitleBar } from '../widget/CommonTitleBar';
import { SafeAreaLayout } from '../widget/SafeAreaLayout';
import { LengthMetrics } from '@kit.ArkUI';
import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';
import { LLMConfig } from '../config/LLMConfig';
import { LLMConfigUtil } from '../config/LLMConfigUtil';
import { ModelAddAndEditPageParam } from './ModelAddAndEditPage';

/**
 * 模型供应商页面
 */
@HMRouter({ pageUrl: PageConstant.PAGE_MODEL_PROVIDER })
@ComponentV2
export struct ModelProviderPage {
  @Local private configList: LLMConfig.Config[] | undefined = undefined

  aboutToAppear(): void {
    this.configList = LLMConfigUtil.getInstance().getConfigList()
  }

  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        CommonTitleBar({
          title: $r('app.string.llm_model_provider'),
          onBackClick: () => {
            HMRouterMgr.pop()
          }
        })
          .id('title_bar')

        List() {
          ForEach(this.configList, (item: LLMConfig.Config) => {
            ListItem() {
              // Text(item.id + '--' + item.brandName)
              Row() {
                Button() {
                  Text(item.brand ?? '')
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
                // HMRouterMgr.push({
                //   pageUrl: PageConstant.PAGE_MODEL_ADD_EDIT,
                //   param: {
                //     type: 'edit',
                //     brandId: item.brandId,
                //     editConfig: item,
                //   } as ModelAddAndEditPageParam
                // })
                HMRouterMgr.push({
                  pageUrl: PageConstant.PAGE_MODEL_ADD_EDIT,
                  param: {
                    type: 'add',
                    brandId: item.id,
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
      }

    }
  }
}