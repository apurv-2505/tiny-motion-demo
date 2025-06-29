const wdio = require("webdriverio");

const opts = {
  path: "/wd/hub",
  port: 4723,
  capabilities: {
    platformName: "Android",
    deviceName: "Android Emulator",
    app: "./build/app/outputs/flutter-apk/app-release.apk",
    automationName: "UiAutomator2",
    appWaitActivity: "com.yourdomain.demo_app.MainActivity", // Adjust if needed
  },
};

async function main() {
  const client = await wdio.remote(opts);

  const appBar = await client.$("~AppBar"); // Using Flutter key as Accessibility ID
  const isVisible = await appBar.isDisplayed();

  if (isVisible) {
    console.log("✅ AppBar is visible.");
  } else {
    throw new Error("❌ AppBar not found.");
  }

  await client.deleteSession();
}

main();
