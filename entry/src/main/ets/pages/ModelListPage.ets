import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import { PageConstant } from '../constant/PageConstant'
import { CommonTitleBar } from '../widget/CommonTitleBar'
import { SafeAreaLayout } from '../widget/SafeAreaLayout'

/**
 * 模型设置页面
 */
@HMRouter({ pageUrl: PageConstant.PAGE_MODEL_LIST })
@ComponentV2
export struct ModelListPage {
  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        CommonTitleBar({
          title: $r('app.string.llm_set'),
          onBackClick: () => {
            HMRouterMgr.pop()
          }
        })
      }
    }
  }
}