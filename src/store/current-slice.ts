import type { Project } from "@/models/project-model";
import type { StateCreator } from "zustand";

export interface ProjectSlice {
  currentPath: string | null;
  projects: Project[];
  loading: boolean;
  refreshing: boolean;

  setCurrentPath: (path: string) => void;
  setProjects: (projects: Project[]) => void;
  setLoading: (loading: boolean) => void;
  setRefreshing: (refreshing: boolean) => void;

  loadProjects: () => Promise<void>;
  handleSelectDirectory: () => Promise<void>;
  handleRefresh: () => Promise<void>;
  handleOpenWithVSCode: (projectPath: string) => Promise<boolean>;
}

export const createProjectSlice: StateCreator<ProjectSlice, [["zustand/devtools", never]]> = (set, get) => ({
  currentPath: "C:\\Users\\jkl3_\\Desktop\\Developer",
  projects: [],
  loading: false,
  refreshing: false,

  setCurrentPath: (path: string) => set({ currentPath: path }),
  setProjects: (projects: Project[]) => set({ projects }),
  setLoading: (loading: boolean) => set({ loading }),
  setRefreshing: (refreshing: boolean) => set({ refreshing }),

  loadProjects: async () => {
    const { currentPath } = get();

    if (!currentPath) {
      return;
    }

    set({ loading: true });

    try {
      const projectsList = await window.api.getProjects(currentPath);
      set({
        projects: projectsList,
        loading: false
      });
    } catch (error) {
      console.error('Error al cargar proyectos:', error);
      set({
        projects: [],
        loading: false
      });
    }
  },

  handleSelectDirectory: async () => {
    try {
      const selectedPath = await window.api.selectDirectory();
      if (selectedPath) {
        set({ currentPath: selectedPath });
        await get().loadProjects();
      }
    } catch (error) {
      console.error('Error al seleccionar directorio:', error);
    }
  },

  handleRefresh: async () => {
    const { currentPath } = get();
    if (currentPath) {
      set({ refreshing: true });
      try {
        await get().loadProjects();
      } catch (error) {
        console.error('Error al actualizar proyectos:', error);
      } finally {
        setTimeout(() => {
          set({ refreshing: false });
        }, 1000);
      }
    }
  },

  handleOpenWithVSCode: async (projectPath: string) => {
    try {
      const success = await window.api.openWithVSCode(projectPath);
      if (!success) {
        alert('Error al abrir VSCode. Asegúrate de que está instalado y accesible desde la terminal.');
        return false;
      }
      return true;
    } catch (error) {
      console.error('Error al abrir con VSCode:', error);
      return false;
    }
  }
});

