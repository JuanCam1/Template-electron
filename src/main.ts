import { app, BrowserWindow, Menu } from "electron";
import { shell } from "electron";
import path from "node:path";
import fs from "node:fs";
import { platform } from "node:process";
import { template } from "./api/libs";

let mainWindow: BrowserWindow;

const createWindow = () => {
  try {
    mainWindow = new BrowserWindow({
      icon: path.join(__dirname, "../images/logo.png"),
      title: "CodeLaunch",
      minHeight: 600,
      minWidth: 500,
      frame: true,
      show: true,
      webPreferences: {
        preload: path.join(__dirname, "preload.js"),
      },
    });

    mainWindow.maximize();

    const menu = Menu.buildFromTemplate(template);
    Menu.setApplicationMenu(menu);

    mainWindow.webContents.setWindowOpenHandler((details) => {
      shell.openExternal(details.url);
      return { action: "deny" };
    });

    if (MAIN_WINDOW_VITE_DEV_SERVER_URL) {
      mainWindow.loadURL(MAIN_WINDOW_VITE_DEV_SERVER_URL);
    } else {
      mainWindow.loadFile(
        path.join(__dirname, `../renderer/${MAIN_WINDOW_VITE_NAME}/index.html`),
      );
    }

    mainWindow.webContents.openDevTools({
      mode: "detach",
    });
  } catch (error) {
    fs.writeFileSync("/tmp/electron-app-error.log", String(error));
  }
};

app.on("ready", createWindow);

app.on("window-all-closed", () => {
  if (platform !== "darwin") {
    app.quit();
  }
});

app.on("activate", () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});
