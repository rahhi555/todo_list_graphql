<template>
  <main class="container">
    <input type="email" placeholder="email" v-model="loginParams.email" />
    <input type="password" placeholder="password" v-model="loginParams.password" />
    <input type="submit" @click="login()" />
  </main>
</template>

<script setup lang="ts">
import { reactive } from "vue";
import { useLoginMutation } from "@/generated/graphql";
import { useUserStore } from "@/stores/currentUser";
import { useRouter } from "vue-router";

const loginParams = reactive({
  email: "",
  password: "",
});

const { mutate: login } = useLoginMutation(() => ({
  variables: {
    email: loginParams.email,
    password: loginParams.password,
  },
  update: (_, { data }) => {
    useUserStore().login(data!);
    const router = useRouter();    
    router.push({ path: "/todos" });
  },
}));
</script>
