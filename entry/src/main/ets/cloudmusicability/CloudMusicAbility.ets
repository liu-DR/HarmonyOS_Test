import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

export default class CloudMusicAbility extends UIAbility {
  // 创建应用进程入口
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    const abilityParams = want.parameters?.abilityParams;
    AppStorage.setOrCreate<string>('abilityParams', JSON.stringify(abilityParams));
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/cloud_music_pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');

      // 设置应用全屏展示
      let windowClass: window.Window = windowStage.getMainWindowSync(); // 获取应用主窗口

      // 1. 设置窗口全屏
      // let isLayoutFullScreen = true;
      // windowClass.setWindowLayoutFullScreen(false).then(() => {
      //   console.info('Succeeded in setting the window layout to full-screen mode.');
      // }).catch((err: BusinessError) => {
      //   console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
      // });

      // 2. 设置状态栏隐藏
      /**
       * @file{setSpecificSystemBarEnabled}
       * @param [name] 需要设置显示或隐藏的系统栏类型 'status'-顶部状态栏、'navigation'-三键导航栏(HarmonyOS系统不支持该能力)、'navigationIndicator'-底部导航栏
       * @param [enable] 窗口全屏模式下显示或隐藏状态栏或导航栏
       * */
      // windowClass.setSpecificSystemBarEnabled('status', true, true).then(() => {
      //   console.info('Succeeded in setting the status bar to be invisible.');
      // }).catch((err: BusinessError) => {
      //   console.error(`Failed to set the status bar to be invisible. Code is ${err.code}, message is ${err.message}`);
      // });

      // 2. 设置导航区域隐藏
      windowClass.setSpecificSystemBarEnabled('navigationIndicator', false, true).then(() => {
        console.info('Succeeded in setting the navigation indicator to be invisible.');
      }).catch((err: BusinessError) => {
        console.error(`Failed to set the navigation indicator to be invisible. Code is ${err.code}, message is ${err.message}`);
      });
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
