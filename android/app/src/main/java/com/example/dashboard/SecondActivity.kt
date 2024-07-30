package com.example.dashboard

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class SecondActivity : AppCompatActivity() {

    private val CHANNEL = "samples.flutter.dev/channel"


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_dynamic)

        val flutterEngine = FlutterEngineCache.getInstance().get("my_engine_id")


        val layout = findViewById<LinearLayout>(R.id.dynamic_layout)

        val buttonGoBack = Button(this)
        buttonGoBack.text = "Go Back"
        buttonGoBack.setOnClickListener {
            finish()
        }

        val editText = EditText(this)
        editText.hint = "Enter text here"

        val button = Button(this)
        button.text = "Send to Flutter"
        button.setOnClickListener {
            val inputText = editText.text.toString()
            flutterEngine?.dartExecutor?.binaryMessenger?.let { it1 ->
                MethodChannel(
                    it1,
                    CHANNEL
                ).invokeMethod("showDialog", inputText)
            }
            finish()
        }

        val params = intent.getStringExtra("params")
        val textView = TextView(this)
        textView.textSize = 20f
        textView.minHeight = 100
        textView.textAlignment = TextView.TEXT_ALIGNMENT_CENTER

        params?.let {
            val jsonObject = JSONObject(it)
            val formattedString = jsonObject.toString(4) // Indentation level of 4
            textView.text = formattedString
        }


        val layoutParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        )
        layoutParams.gravity = android.view.Gravity.CENTER
        textView.layoutParams = layoutParams

        layout.addView(buttonGoBack)
        layout.addView(textView)
        layout.addView(editText)
        layout.addView(button)
    }
}