package com.mycompany.appvendedores

import android.content.ContentValues
import android.net.Uri
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.OutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.mycompany.appvendedores/media_store"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "saveFile" -> {
                    val fileBytes = call.argument<ByteArray>("fileBytes")
                    val fileName = call.argument<String>("fileName")
                    val mimeType = call.argument<String>("mimeType")
                    if (fileBytes != null && fileName != null && mimeType != null) {
                        try {
                            val filePath = saveFileUsingMediaStore(fileBytes, fileName, mimeType)
                            if (filePath != null) {
                                result.success(filePath)
                            } else {
                                result.error("ERROR", "Error al guardar el archivo", null)
                            }
                        } catch (e: Exception) {
                            result.error("EXCEPTION", "Excepción: ${e.message}", null)
                        }
                    } else {
                        result.error("INVALID_ARGUMENTS", "Argumentos inválidos", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun saveFileUsingMediaStore(fileBytes: ByteArray, fileName: String, mimeType: String): String? {
        val contentValues = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, fileName)
            put(MediaStore.MediaColumns.MIME_TYPE, mimeType)
            put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
        }

        println("ContentValues: $contentValues")

        val resolver = applicationContext.contentResolver
        val uri: Uri? = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, contentValues)
        if (uri != null) {
            println("URI generado: $uri")
            try {
                val outputStream: OutputStream? = resolver.openOutputStream(uri)
                if (outputStream != null) {
                    outputStream.use {
                        it.write(fileBytes)
                        println("Archivo guardado correctamente en: $uri")
                    }
                    return uri.toString()
                } else {
                    println("Error: OutputStream es nulo")
                    return null
                }
            } catch (e: Exception) {
                println("Error al guardar el archivo: ${e.message}")
                e.printStackTrace()
                return null
            }
        } else {
            println("Error: No se pudo crear el URI para el archivo")
            return null
        }
    }
}