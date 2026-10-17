package com.toly1994.flutter_unit

import android.content.ContentValues
import android.content.Context
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

/** 将原始图片字节写入系统相册；下载和保存均不阻塞界面线程。 */
object ArticleImageChannel {
    fun register(context: Context, messenger: BinaryMessenger) {
        val queue = messenger.makeBackgroundTaskQueue()
        MethodChannel(messenger, "com.toly1994.flutter_unit/article_images",
            io.flutter.plugin.common.StandardMethodCodec.INSTANCE, queue
        ).setMethodCallHandler { call, result ->
            if (call.method != "saveToGallery" || Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
                result.notImplemented()
                return@setMethodCallHandler
            }
            val bytes = call.argument<ByteArray>("bytes")
            val name = call.argument<String>("name")
            val mime = call.argument<String>("mime")
            if (bytes == null || bytes.isEmpty() || name.isNullOrBlank() ||
                name.contains('/') || name.contains('\\') || mime == null || !mime.startsWith("image/")) {
                result.error("invalid_image", "图片内容不可用", null)
                return@setMethodCallHandler
            }
            val resolver = context.applicationContext.contentResolver
            var pending: android.net.Uri? = null
            try {
                val values = ContentValues().apply {
                    put(MediaStore.Images.Media.DISPLAY_NAME, name)
                    put(MediaStore.Images.Media.MIME_TYPE, mime)
                    put(MediaStore.Images.Media.RELATIVE_PATH, "${Environment.DIRECTORY_PICTURES}/FlutterUnit")
                    put(MediaStore.Images.Media.IS_PENDING, 1)
                }
                val uri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)
                    ?: throw IllegalStateException("无法创建相册图片")
                pending = uri
                val output = resolver.openOutputStream(uri)
                    ?: throw IllegalStateException("无法写入相册图片")
                output.use { it.write(bytes) }
                val published = resolver.update(uri, ContentValues().apply {
                    put(MediaStore.Images.Media.IS_PENDING, 0)
                }, null, null)
                if (published != 1) throw IllegalStateException("无法发布相册图片")
                result.success(uri.toString())
            } catch (error: Exception) {
                // 写入失败时清理半成品，不向相册暴露损坏文件。
                pending?.let { uri -> runCatching { resolver.delete(uri, null, null) } }
                result.error("save_failed", "无法保存到相册", null)
            }
        }
    }
}
