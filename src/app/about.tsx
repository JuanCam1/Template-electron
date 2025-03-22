import Title from "@/components/shared/title";
import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/about")({
  component: About,
});

function About() {
  return (
    <div className="space-y-2 text-sm">
      <Title>About</Title>
      <p>
        Welcome to about page, this is a lazy loaded component, with file-based
        router, provided by{" "}
        <span className="bg-secondary px-1 font-mono text-secondary-foreground">
          tanstack/react-router
        </span>
        .
      </p>
    </div>
  );
}
