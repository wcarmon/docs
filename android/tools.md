# Overview
1. Pre-approved Tools & Patterns
1. Rejected tools
- (as of June 2025)


# Pre-approved Tools
1. Background work: [WorkManager](https://developer.android.com/develop/background-work/background-tasks/persistent/getting-started)
1. CI: [Proguard](https://developer.android.com/topic/performance/app-optimization/enable-app-optimization)
1. Code: [Kotlin](https://kotlinlang.org/)
1. Concurrency: [Coroutines](https://kotlinlang.org/docs/coroutines-overview.html)
1. Images: [Coil](https://coil-kt.github.io/coil/)
1. Nav: [Jetpack Navigation](https://developer.android.com/guide/navigation)
1. Nav: [NavController](https://developer.android.com/guide/navigation/navcontroller)
1. Nav: [Safe Args](https://developer.android.com/guide/navigation/use-graph/safe-args)
1. Net: [OkHttp](https://square.github.io/okhttp/)
1. Runtime analysis: [LeakCanary](https://square.github.io/leakcanary/)
1. Serialization: [Jackson](https://github.com/FasterXML/jackson)
1. SQL: [SQLDelight](https://github.com/sqldelight/sqldelight)
1. State Management: [SharedFlow](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines.flow/-shared-flow/)
1. State Management: [StateFlow](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines.flow/-state-flow/)
1. Static Analysis: [Detekt](https://github.com/detekt/detekt)
1. Static Analysis: [ktlint](https://github.com/pinterest/ktlint)
1. Test: [JUnit](TODO) (TODO: 4 or 5)
1. UI Controls: [RecyclerView](https://developer.android.com/develop/ui/views/layout/recyclerview), (and [Adapter](https://developer.android.com/reference/androidx/recyclerview/widget/RecyclerView.Adapter), etc)
1. UI State: [ViewModel](https://developer.android.com/topic/libraries/architecture/viewmodel)
1. UI: [Material Design](https://developer.android.com/develop/ui/views/theming/look-and-feel)
1. UI: [ViewBinding](https://developer.android.com/topic/libraries/view-binding)


# Pre-approved Patterns
1. [Single Activity, multiple Fragments](https://developer.android.com/guide/fragments/communicate)
1. Dumb Activities, Fragments, Application class
1. DI: constructor of each class, wire in Application class


# In review
1. Caching: [caffeine](TODO)
1. Concurrency: [LiveData](TODO)
1. DI: [Koin](https://insert-koin.io/docs/setup/koin)
1. Log: [Timber](https://github.com/JakeWharton/timber)
1. Nav: [Cicerone](https://github.com/terrakok/Cicerone)
1. Test: [awaitility](https://github.com/awaitility/awaitility)
1. Test: [Mockito for android](TODO)
1. Test: [MockK](https://mockk.io/ANDROID.html)
1. Test: [Roboletric](TODO)
1. Test: [Truth](https://truth.dev/)
1. Test: [Turbine](https://github.com/cashapp/turbine)
1. TODO: charts
1. TODO: compression (apache commons?)
1. TODO: configuration management
1. TODO: stats/metrics
1. TODO: UI: pull to refresh


# Rejected tools
1. Background work: ~~[IntentService](https://developer.android.com/reference/android/app/IntentService)~~
1. CI: ~~[maven](https://maven.apache.org/)~~
1. Concurrency: ~~[AsyncTask](https://developer.android.com/reference/android/os/AsyncTask)~~
1. Concurrency: ~~[Handler](https://developer.android.com/reference/android/os/Handler)~~
1. Concurrency: ~~[HandlerThread](https://developer.android.com/reference/android/os/HandlerThread)~~
1. Concurrency: ~~[LiveData](https://developer.android.com/topic/libraries/architecture/livedata)~~ (Use `StateFlow` instead)
1. Concurrency: ~~[Otto](https://square.github.io/otto/)~~
1. Concurrency: ~~[RxAndroid](https://github.com/ReactiveX/RxAndroid)~~
1. Concurrency: ~~[RxJava](https://github.com/ReactiveX/RxJava)~~ (Use `BehaviorSubject` -> `StateFlow`, `Flowable` -> `SharedFlow`)
1. Concurrency: ~~[RxKotlin](https://github.com/ReactiveX/RxKotlin)~~
1. Concurrency: ~~[Thread](https://developer.android.com/reference/java/lang/Thread)~~
1. Crash monitoring: ~~[Fabric](https://firebase.google.com/docs/reference/android/io/fabric/sdk/android/fabric/Fabric)~~
1. DateTime: ~~[JodaTime](https://www.joda.org/joda-time/)~~
1. DI: ~~[Dagger](https://developer.android.com/training/dependency-injection/dagger-android)~~ (replaced by Hilt)
1. DI: ~~[Hilt](https://developer.android.com/training/dependency-injection/hilt-android)~~
1. DI: ~~[KodeIn](https://github.com/kosi-libs/Kodein)~~
1. DI: ~~[Toothpick](https://github.com/stephanenicolas/toothpick)~~
1. Images: ~~[Fresco](https://frescolib.org/)~~ (bloated, frameworky, large)
1. Images: ~~[Glide](https://github.com/bumptech/glide)~~ (only if coil doesnt meet your needs)
1. Images: ~~[Picasso](https://square.github.io/picasso/)~~
1. Images: ~~[UIL](https://github.com/nostra13/Android-Universal-Image-Loader)~~ (abandoned)
1. Nav: ~~[FragmentManager](https://developer.android.com/guide/fragments/fragmentmanager#using)~~
1. Nav: ~~[FragmentTransaction](https://developer.android.com/reference/androidx/fragment/app/FragmentTransaction.html)~~
1. Nav: ~~[startActivityForResult, onActivityResult](https://developer.android.com/training/basics/intents/result)~~
1. Net: ~~[Apache Http Client](https://hc.apache.org/httpcomponents-client-4.5.x/index.html)~~ (Okhttp is lighter, faster, simpler, has less deps)
1. Net: ~~[AsyncHttpClient](https://github.com/android-async-http/android-async-http)~~
1. Net: ~~[Fuel](https://github.com/kittinunf/fuel)~~
1. Net: ~~[HttpURLConnection ](https://developer.android.com/reference/java/net/HttpURLConnection)~~
1. Net: ~~[Ion](https://github.com/koush/ion)~~
1. Net: ~~[KTor client](https://ktor.io/docs/client-engines.html)~~
1. Net: ~~[Retrofit](https://square.github.io/retrofit/)~~
1. Net: ~~[RoboSpice](https://github.com/stephanenicolas/robospice)~~ (abandoned)
1. Net: ~~[Spring for Android - RestTemplate](TODO)~~
1. Net: ~~[Volley](https://google.github.io/volley/)~~
1. Permissions: ~~[Dexter](https://github.com/Karumi/Dexter)~~
1. Serialization: ~~[Gson](https://github.com/google/gson)~~
1. Serialization: ~~[Mochi](https://github.com/square/moshi)~~
1. Serialization: ~~[Protobuf](TODO)~~ (complexity over json)
1. SQL: ~~[Room](https://developer.android.com/training/data-storage/room)~~ too "frameworky", hard to test, hard to optimize (compare to SQLDelight)
1. SQL: ~~[GreenDAO](https://github.com/greenrobot/greenDAO)~~
1. SQL: ~~[objectbox](https://objectbox.io/)~~
1. SQL: ~~[ORMLite](https://ormlite.com/)~~
1. SQL: ~~[Realm](https://github.com/realm/realm-java)~~
1. SQL: ~~[SQLiteOpenHelper](https://developer.android.com/reference/android/database/sqlite/SQLiteOpenHelper)~~
1. Stats: ~~[Crashlytics](https://firebase.google.com/products/crashlytics)~~
1. Test: ~~[Hamcrest](https://hamcrest.org/JavaHamcrest/)~~ (Dependency-hell, shaded versions, abandonware, redundant matchers, ...)
1. Test: ~~[PowerMock](https://github.com/powermock/powermock)~~
1. UI: ~~[anvil](https://github.com/anvil-ui/anvil)~~
1. UI: ~~[ButterKnife](https://github.com/JakeWharton/butterknife)~~ (use ViewBinding instead)
1. UI: ~~[DataBinding](https://developer.android.com/topic/libraries/data-binding)~~
1. UI: ~~[findViewById](https://developer.android.com/reference/android/view/View#findViewById(int))~~
1. UI: ~~[GridView](https://developer.android.com/reference/android/widget/GridView)~~ Use `RecyclerView` instead
1. UI: ~~[ListView](https://developer.android.com/reference/android/widget/ListView)~~ Use `RecyclerView` instead
1. UI: ~~[Kotlin Android Extensions (Kotlin Synthetics)](https://developer.android.com/topic/libraries/view-binding/migration)~~ (Use ViewBinding instead)


# Unfiled
1. TODO: check Thoughtworks 