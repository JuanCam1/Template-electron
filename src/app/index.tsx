import { useEffect } from "react";
import { createFileRoute } from "@tanstack/react-router";

import { useProjectStore } from "@/store";

import { Separator } from "@/components/ui/separator";

import Header from "@/sections/header";
import ProjectList from "@/sections/project-list";

export const Route = createFileRoute("/")({
  component: Index,
});


function Index() {
  const currentPath = useProjectStore(state => state.currentPath);
  const loading = useProjectStore(state => state.loading);
  const projects = useProjectStore(state => state.projects);
  const refreshing = useProjectStore(state => state.refreshing);
  const loadProjects = useProjectStore(state => state.loadProjects);

  const handleSelectDirectory = useProjectStore(state => state.handleSelectDirectory);
  const handleRefresh = useProjectStore(state => state.handleRefresh);

  useEffect(() => {
    loadProjects();
  }, [])


  return (
    <div className="flex flex-col bg-white dark:bg-zinc-900 px-5 rounded-md w-full lg:w-[80%] min-h-[95%]">
      <Header
        onSelectDirectory={handleSelectDirectory}
        onRefresh={handleRefresh}
        currentPath={currentPath}
        canRefresh={!!currentPath && !loading}
      />
      <Separator />
      <div className="flex-1 pt-3 rounded-sm overflow-hidden">
        <h2 className="my-0 pb-3 font-semibold dark:text-white text-lg text-center">Proyectos ({projects.length})</h2>
        <Separator />

        {projects.length === 0 ? (
          <div className="py-10 text-muted-foreground text-base text-center">
            No hay proyectos para mostrar. Selecciona una carpeta o asegúrate de que la carpeta contiene proyectos.
          </div>
        ) : (
          <ProjectList loading={loading || refreshing} />
        )}
      </div>

    </div>
  )

}
