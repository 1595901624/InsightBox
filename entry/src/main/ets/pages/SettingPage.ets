import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';
import { CommonTitleBar } from '../widget/CommonTitleBar';
import { SafeAreaLayout } from '../widget/SafeAreaLayout';

@HMRouter({ pageUrl: PageConstant.PAGE_SETTING })
@ComponentV2
export struct SettingPage {
  build() {
    SafeAreaLayout() {
      RelativeContainer() {
        CommonTitleBar({
          title: $r('app.string.set'),
          onBackClick: () => {
            HMRouterMgr.pop()
          }
        })
      }
    }
  }
}