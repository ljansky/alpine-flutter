FROM openjdk:17-jdk-alpine3.13

RUN apk add --update curl unzip git && rm -f /var/cache/apk/*

# Android Tools
ARG ANDROID_SDK_TOOLS="4333796"
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip"
ENV ANDROID_SDK_ROOT="/usr/local/android"
ENV ANDROID_SDK_ARCHIVE="/tmp/android.zip"
RUN curl --output "${ANDROID_SDK_ARCHIVE}" --url "${ANDROID_SDK_URL}" \
  && unzip -q -d "${ANDROID_SDK_ROOT}" "${ANDROID_SDK_ARCHIVE}" \
  && rm "${ANDROID_SDK_ARCHIVE}"

# Android SDK
RUN yes "y" | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "tools" \
  "platform-tools" \
  "extras;android;m2repository" \
  "extras;google;m2repository" \
  "patcher;v4"
