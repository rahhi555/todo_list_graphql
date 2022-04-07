import { defineStore } from "pinia";
import type { User, UserCreateMutation } from "../generated/graphql";

type OptionalUser = { [K in keyof User]?: User[K] };

export const useUserStore = defineStore("user", {
  state: (): { user: OptionalUser } => {
    return {
      user: {
        id: undefined,
        email: undefined,
      },
    };
  },

  getters: {
    currentUser: (state) => state.user,

    hasCurrentUser: (state) => !!state.user.id && !!state.user.email,
  },

  actions: {
    login(data: UserCreateMutation) {
      if ("userCreate" in data) {
        sessionStorage.setItem("todo-user", data.userCreate!.token);
        this.setUser(data.userCreate!.user);
      }
    },

    setUser(user: OptionalUser) {
      const { id, email } = user;
      this.user = { id, email };
    },
  },
});
