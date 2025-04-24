import { HMDefaultGlobalAnimator, HMNavigation } from '@hadss/hmrouter';
import { AttributeUpdater } from '@kit.ArkUI';
import { PageConstant } from '../constant/PageConstant';

@Entry
@Component
struct Index {
  modifier: AttributeUpdater<NavigationAttribute> = new MyNavModifier();

  aboutToAppear(): void {

  }

  onPageShow(): void {

  }

  build() {
    Column() {
      // 使用HMNavigation容器
      HMNavigation({
        navigationId: 'mainNavigation', homePageUrl: PageConstant.PAGE_CHAT,
        options: {
          standardAnimator: HMDefaultGlobalAnimator.STANDARD_ANIMATOR,
          dialogAnimator: HMDefaultGlobalAnimator.DIALOG_ANIMATOR,
          modifier: this.modifier
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}

class MyNavModifier extends AttributeUpdater<NavigationAttribute> {
  initializeModifier(instance: NavigationAttribute): void {
    instance.hideNavBar(true);
  }
}