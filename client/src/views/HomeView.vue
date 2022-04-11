<template>
  <div>
    <div v-if="hasCurrentUser">
      <h1>after hoge</h1>
      <RouterLink to="/todos">todos</RouterLink>
    </div>
    <div v-else>
      <h1>before home</h1>
      <RouterLink to="/signup">signup</RouterLink>
      <RouterLink to="/login">login</RouterLink>
    </div>
  </div>
</template>

<script setup lang="ts">
import { RouterLink } from "vue-router";
import { useUserStore } from "@/stores/currentUser";

const { hasCurrentUser } = useUserStore();
</script>
