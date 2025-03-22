import Navbar from "@/components/shared/navbar";
import TitleBar from "@/components/shared/title-bar";
import { createRootRoute, Outlet } from "@tanstack/react-router";

export const Route = createRootRoute({
  component: () => (
    <>
      <TitleBar />
      <Navbar />
      <div className="px-4 pt-16">
        <Outlet />
      </div>
    </>
  ),
});
