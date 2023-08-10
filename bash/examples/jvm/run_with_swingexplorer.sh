#!/bin/bash

#set -x # uncomment to debug script
set -e # exit on first error
set -o pipefail
set -u # fail on unset var


# --------------------------------------------
# -- Constants
# --------------------------------------------
readonly PARENT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
readonly JAVA=$(which java)


# ---------------------------------------------
# -- Config
# ---------------------------------------------
readonly APP_JAR="build/libs/app.uber.jar"
readonly APP_MAIN_CLASS="com.foo.bar.MainApp"
readonly JAVAASSIST_JAR="$HOME/.gradle/caches/modules-2/files-2.1/javassist/javassist/3.12.1.GA/526633327faa61aee448a519e8a4d53ec3057885/javassist-3.12.1.GA.jar"
readonly SWINGEXPLORER_AGENT_JAR="$HOME/.gradle/caches/modules-2/files-2.1/org.swingexplorer/swingexplorer-agent/1.7.0/6d12517b8676251f4548ed50e06e9b662f397ac2/swingexplorer-agent-1.7.0.jar"
readonly SWINGEXPLORER_CORE_JAR="$HOME/.gradle/caches/modules-2/files-2.1/org.swingexplorer/swingexplorer-core/1.7.0/2b0b033dbf45fc336b52789636330e02bac456b3/swingexplorer-core-1.7.0.jar"


# ---------------------------------------------
# -- Build
# ---------------------------------------------
cd "$PARENT_DIR" >/dev/null 2>&1

./gradlew \
  spotlessApply \
  build \
  jar \
  -x test -x pmdTest -x pmdMain \
  -q


# ---------------------------------------------
# -- Run
# ---------------------------------------------
$JAVA \
-javaagent:"$SWINGEXPLORER_AGENT_JAR" \
-Xbootclasspath/a:"$APP_JAR:$SWINGEXPLORER_AGENT_JAR:$SWINGEXPLORER_CORE_JAR:$JAVAASSIST_JAR" \
--enable-preview \
org.swingexplorer.Launcher \
"$APP_MAIN_CLASS"
