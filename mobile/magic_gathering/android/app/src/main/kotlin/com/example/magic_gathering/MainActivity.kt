package com.example.magic_gathering

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity

import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.DefaultCompany.MagicGathering.UnityPlayerActivity

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "magicgathering/bridge").setMethodCallHandler { call, result ->
            when (call.method) {
                "startUnityActivity" -> {
                    val cardBase64Image: String = call.argument<String>("cardBase64Image") as String
                    val cardsBase64Image: ArrayList<String> = call.argument<ArrayList<String>>("cardsBase64Image") as ArrayList<String>
                    startMainActivity(cardBase64Image, cardsBase64Image)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startMainActivity(cardBase64Image: String, cardsBase64Image: ArrayList<String>) {

        val parsedCardsBase64Image = Array<String>(cardsBase64Image.size) { "" }
        cardsBase64Image.forEachIndexed { index, item ->
            parsedCardsBase64Image[index] = item
        }

        val intent = Intent(this, UnityPlayerActivity::class.java).apply {
            putExtra("cardBase64Image", cardBase64Image)
            putExtra("cardsBase64Image", parsedCardsBase64Image)
        }
        startActivity(intent)
    }
}
