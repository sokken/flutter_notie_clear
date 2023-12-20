package no.sourcerer.flutter_notie_clear

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterNotieClearPlugin */
class FlutterNotieClearPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_notie_clear")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.getApplicationContext()

    // create a notification channel for test notification
    val notie_m = context.getSystemService( Context.NOTIFICATION_SERVICE ) as NotificationManager
    val channel = NotificationChannel(
      "test",
      "test_channel",
      NotificationManager.IMPORTANCE_DEFAULT
    )
    notie_m.createNotificationChannel( channel )
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
      return
    }

    if ( call.method == "clear_all" ) {
      val notie_m = context.getSystemService( Context.NOTIFICATION_SERVICE ) as NotificationManager
      notie_m.cancelAll()
      result.success( "" )
      return
    }

    if ( call.method == "create_test_notie" ) {
      val args : ArrayList<String> = call.arguments<ArrayList<String>>() ?: arrayListOf( "asd", "qwe" )
      val t : String = args[ 0 ]
      val b : String = args[ 1 ]

      val intent = Intent( context, FlutterNotieClearPlugin::class.java ).apply {
        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
      }
      val pendingIntent : PendingIntent = PendingIntent.getActivity(
        context,
        0,
        intent,
        PendingIntent.FLAG_IMMUTABLE
      )

      val builder = NotificationCompat.Builder( context, "test" )
        .setSmallIcon( R.drawable.ic_stat_name )
        .setContentTitle( t )
        .setContentText( b )
        .setPriority( NotificationCompat.PRIORITY_DEFAULT )
        .setContentIntent( pendingIntent )

      with( NotificationManagerCompat.from( context )) {
        notify( 4, builder.build())
      }

      result.success( "" )
      return
    }

    result.notImplemented()

  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
