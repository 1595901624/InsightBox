class StringUtil {
  /**
   * 获取字符串
   * @param resourceStr
   * @returns
   */
  getString(resourceStr: ResourceStr): string {
    if (typeof resourceStr == "string") {
      return resourceStr
    }
    return getContext(this).resourceManager.getStringSync(resourceStr.id)
  }

  /**
   * 判断字符串是否为空
   * @param resourceStr
   * @returns
   */
  isNullOrEmpty(str?: string): boolean {
    return str == null || str.length === 0
  }
}

export const stringUtil = new StringUtil()