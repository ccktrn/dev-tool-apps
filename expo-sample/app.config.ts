import { type ExpoConfig } from "expo/config";

const config: ExpoConfig = {
  name: "expo-sample",
  slug: "expo-sample",
  version: "1.0.0",
  orientation: "portrait",
  icon: "./assets/images/icon.png",
  scheme: "develop",
  userInterfaceStyle: "automatic",
  // updates: {
  //   url: "https://u.expo.dev/601a26a0-d9f9-40fe-a56a-1efa74722c1f",
  // },
  runtimeVersion: {
    policy: "appVersion",
  },
  splash: {
    image: "./assets/images/splash-icon.png",
    resizeMode: "contain",
    backgroundColor: "#ffffff",
  },
  ios: {
    supportsTablet: true,
    newArchEnabled: true,
    bundleIdentifier: "cc.ktrn.expoSample",
  },
  android: {
    newArchEnabled: true,
    adaptiveIcon: {
      foregroundImage: "./assets/images/adaptive-icon.png",
      backgroundColor: "#ffffff"
    },
    package: "cc.ktrn.expoSample",
    // googleServicesFile: "./google-services.json",
  },
  web: {
    bundler: "metro",
    output: "static",
    favicon: "./assets/images/favicon.png"
  },
  extra: {
    eas: {
      projectId: "46dd2b22-7352-446e-9a3d-be2639e6193d"
    },
    router: {
      origin: false
    },
  },
  owner: "riku_kishimoto",
  plugins: [
    "expo-router",
    [
      "expo-splash-screen",
      {
        image: "./assets/images/splash-icon.png",
        imageWidth: 200,
        resizeMode: "contain",
        backgroundColor: "#ffffff"
      }
    ],
    [
      "expo-camera",
      {
        cameraPermission: "Allow $(PRODUCT_NAME) to access your camera",
        microphonePermission: "Allow $(PRODUCT_NAME) to access your microphone",
        recordAudioAndroid: true,
      },
      
    ],
  ],
};

export default config;
