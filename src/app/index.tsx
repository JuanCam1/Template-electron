
import Title from "@/components/shared/title";
import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/")({
  component: Index,
});

function Index() {
  return (
    <div
      className="flex flex-col justify-between items-center gap-8 bg-background pb-8 text-foreground"
    >
      <Title>Electron App Boilerplate</Title>
      <h2>App created with Electron </h2>

    </div>
  );
}
