<template>
  <main class="container">
    <input type="email" placeholder="email" v-model="signupParams.email" />
    <input
      type="password"
      placeholder="password"
      v-model="signupParams.password"
    />
    <input
      type="password"
      placeholder="password confirmation"
      v-model="signupParams.passwordConfirmation"
    />
    <input type="submit" @click="userCreate()" />
  </main>
</template>

<script setup lang="ts">
import { reactive } from "vue";
import { useUserCreateMutation } from "@/generated/graphql";
import { useUserStore } from "@/stores/currentUser";

const signupParams = reactive({
  email: "",
  password: "",
  passwordConfirmation: "",
});

const { mutate: userCreate } = useUserCreateMutation(() => ({
  variables: {
    email: signupParams.email,
    password: signupParams.password,
    passwordConfirmation: signupParams.passwordConfirmation,
  },
  update: (_, { data }) => {
    useUserStore().login(data!);
  },
}));
</script>
