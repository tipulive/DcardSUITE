plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.appdev.gym"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"
    //ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    /*compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility=JavaVersion.VERSION_1_8
        targetCompatibility=JavaVersion.VERSION_1_8
    }*/
    kotlinOptions {
        //jvmTarget = "1.8"
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

   /* kotlinOptions {
        jvmTarget = "1.8"
    }

    // Add this new configuration block
    kotlin {
        jvmToolchain {
            languageVersion.set(JavaLanguageVersion.of(8)) // Force Java 8 for all Kotlin compilation
        }
    }*/

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.appdev.gym"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
       // minSdk = flutter.minSdkVersion
        minSdk = 26
        //targetSdk = flutter.targetSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}
dependencies {
    // Add this line for core library desugaring
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    implementation("androidx.multidex:multidex:2.0.1")
}
flutter {
    source = "../.."
}
