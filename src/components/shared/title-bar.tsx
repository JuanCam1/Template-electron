import type { CSSProperties } from "react";
import MenuBar from "./menu-bar/menu-bar";
import { Minus, Square, X } from "lucide-react";

export default function TitleBar() {
  const handleMinimize = () => {
    window.api.minimize();
  };

  const handleMaximize = () => {
    window.api.maximize();
  };

  const handleClose = () => {
    window.api.quit();
  };

  return (
    <div
      style={{ WebkitAppRegion: "drag" } as CSSProperties}
      className="flex justify-between bg-foreground/10 h-10 text-foreground"
    >
      <MenuBar className="flex-1" />
      <div
        className="flex"
        style={{ WebkitAppRegion: "no-drag" } as CSSProperties}
      >
        <button
          type="button"
          className="hover:bg-foreground/20 px-2 transition-colors cursor-default"
          onClick={handleMinimize}
        >
          <Minus size={17} />
        </button>
        <button
          type="button"
          className="hover:bg-foreground/20 px-2 transition-colors cursor-default"
          onClick={handleMaximize}
        >
          <Square size={13} />
        </button>
        <button
          type="button"
          className="hover:bg-destructive/50 dark:hover:bg-destructive px-2 transition-colors cursor-default"
          onClick={handleClose}
        >
          <X size={16} />
        </button>
      </div>
    </div>
  );
}
