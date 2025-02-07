# Overview
1. TODO


# E2E Test
1. Runs on a device (eg. emulator or real phone)
1. Test class annotated with `@RunWith(AndroidJUnit4::class)`
1. dir: `$PROJ_ROOT/app/src/androidTest`
1. Context:
    1. get using `val appContext = InstrumentationRegistry.getInstrumentation().targetContext`
    1. Shared across tests within the test class
    1. NOT reused across test runs


# Integration Test


# Unit Test
1. Runs in local JVM
1. dir: `$PROJ_ROOT/app/src/test`
1. limited to JUnit 4 (cannot use JUnit 5)
