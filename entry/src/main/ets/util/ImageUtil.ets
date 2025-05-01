import { image } from '@kit.ImageKit'

class ImageUtil {
  /**
   * 获取图片资源
   * @param resource 图片资源
   * @returns 图片资源 image.PixelMap
   */
  public async getPixmapFromMedia(resource: Resource): Promise<image.PixelMap> {
    let unit8Array = await getContext(this)?.resourceManager?.getMediaContent({
      bundleName: resource.bundleName,
      moduleName: resource.moduleName,
      id: resource.id
    })
    let imageSource = image.createImageSource(unit8Array.buffer.slice(0, unit8Array.buffer.byteLength))
    let createPixelMap: image.PixelMap = await imageSource.createPixelMap({
      desiredPixelFormat: image.PixelMapFormat.RGBA_8888
    })
    await imageSource.release()
    return createPixelMap
  }
}

export const imageUtil = new ImageUtil()