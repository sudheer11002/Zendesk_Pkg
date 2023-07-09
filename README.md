![Logo](https://github.com/sudheer11002/Zendesk_Pkg/blob/main/message.jpeg)


# Zendesk Chat for Flutter

## Android:

 To setup Zendesk support in android, change app by default style to Zendesk style(android -> app -> src -> main ->  res -> values -> styles.xml)
 and (android -> app -> src -> main -> res -> values.night.xml). Here the style:
 

```dart
         <?xml version="1.0" encoding="utf-8"?>

         <resources>

          <style name="LaunchTheme" parent="Theme.AppCompat.Light.DarkActionBar">
              <item name="android:windowBackground">@drawable/launch_background</item>
          </style>
          <style name="NormalTheme" parent="Theme.AppCompat.Light.DarkActionBar">
              <item name="android:windowBackground">?android:colorBackground</item>
          </style>
       </resources>

```
After that, the style is add the Manifest.xml(android -> app -> src -> main -> AndroidManifest.xml):

```dart
<application
     android:label=“${applicationName}”
     android:name="${applicationName}"
    android:allowBackup ="true"
    android:theme="@style/LaunchTheme"   // add this line 
    android:networkSecurityConfig="@xml/network_security_config"
     android:icon="@mipmap/ic_launcher">
     <activity
         android:name=".MainActivity"
         android:exported="true"
         android:launchMode="singleTop"
         android:theme="@style/LaunchTheme"  // add this line 
         android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
         android:hardwareAccelerated="true"
         android:windowSoftInputMode="adjustResize">
                  <meta-data
           android:name="io.flutter.embedding.android.NormalTheme"
           android:resource="@style/NormalTheme"
           />
         <intent-filter>
             <action android:name="android.intent.action.MAIN"/>
             <category android:name="android.intent.category.LAUNCHER"/>
         </intent-filter>
     </activity>
 </application>












