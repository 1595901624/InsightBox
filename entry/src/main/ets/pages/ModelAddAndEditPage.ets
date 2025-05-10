import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import { PageConstant } from '../constant/PageConstant'
import { CommonTitleBar } from '../widget/CommonTitleBar'
import { SafeAreaLayout } from '../widget/SafeAreaLayout'


export interface ModelAddAndEditPageParam {
  type: 'add' | 'edit'
}

/**
 * 模型新增或者编辑页面
 */
@HMRouter({ pageUrl: PageConstant.PAGE_MODEL_ADD_EDIT })
@ComponentV2
export struct ModelAddAndEditPage {
  @Local type: 'add' | 'edit' = 'add'

  aboutToAppear(): void {
    const param = HMRouterMgr.getCurrentParam() as ModelAddAndEditPageParam
    if (param == undefined) {
      return
    }
    this.type = param.type ?? 'add'
  }

  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        CommonTitleBar({
          title: this.type === 'add' ? $r('app.string.llm_add') : $r('app.string.llm_edit'),
          endText: $r('app.string.llm_save'),
          endTextEnable: true,
          onEndTextClick: () => {

          },
          onBackClick: () => {
            HMRouterMgr.pop()
          }
        })
      }
    }
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