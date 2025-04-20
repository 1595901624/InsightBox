import hilog from "@ohos.hilog";

type LogLevel = 'debug' | 'info' | 'warn' | 'error';

export class LogUtil {
  private tag = "[InsightBox]";
  private domain = 0;
  private enableLog: boolean = true;

  debug(...msg: (string | number | boolean | Object)[]) {
    this.log('debug', ...msg);
  }

  info(...msg: (string | number | boolean | Object)[]) {
    this.log('info', ...msg);
  }

  warn(...msg: (string | number | boolean | Object)[]) {
    this.log('warn', ...msg);
  }

  error(...msg: (string | number | boolean | Object)[]) {
    this.log('error', ...msg);
  }

  /**
   * 设置是否打印日志
   * @param enable 是否打印日志
   */
  setEnableLog(enable: boolean) {
    this.enableLog = enable;
  }

  /**
   * 打印日志
   * @returns 打印日志
   */
  private log(level: LogLevel, ...msg: (string | number | boolean | Object)[]) {
    if (this.enableLog) {
      let logMsg = ''
      for (let i = 0; i < msg.length; i++) {
        const element = msg[i];
        if (typeof element === 'string' || typeof element === 'number' || typeof element === 'boolean') {
          if (i == 0) {
            logMsg += element.toString();
          } else {
            logMsg += ', ' + element.toString();
          }
        } else {
          if (i == 0) {
            logMsg += JSON.stringify(element, null, 2);
          } else {
            logMsg += ', \n' + JSON.stringify(element, null, 2);
          }
        }
      }

      switch (level) {
        case 'debug':
          hilog.debug(this.domain, this.tag, logMsg);
          break;
        case 'info':
          hilog.info(this.domain, this.tag, logMsg);
          break;
        case 'warn':
          hilog.warn(this.domain, this.tag, logMsg);
          break;
        case 'error':
          hilog.error(this.domain, this.tag, logMsg);
          break;
        default:
          break;
      }
    }
  }
}

export const log = new LogUtil();