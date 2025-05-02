import { buffer } from '@kit.ArkTS';
import { GlobalUtil } from './GlobalUtil';
import { log } from './LogUtil';

class FileUtil {
  /**
   * 获取 rawfile 文件下的文件内容
   * @param filePath 文件路径
   * @returns
   */
  getRawFileString(filePath: string): string {
    try {
      log.info(`getRawFileString: ${filePath}`);
      const content = GlobalUtil.getApplicationContext().resourceManager.getRawFileContentSync(filePath)
      return buffer.from(content.buffer).toString()
    } catch (e) {
      log.error(`getRawFileString error: ${filePath}, ${e?.message} ${e?.stack}`);
      return '';
    }
  }
}

export const fileUtil = new FileUtil();