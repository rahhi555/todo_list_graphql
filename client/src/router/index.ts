import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import { useUserStore } from '../stores/currentUser'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
      meta: { requiresAuth: false },
    },
    {
      path: "/signup",
      name: "signup",
      component: () => import("../views/default/SignUp.vue"),
      meta: { requiresAuth: false },
    },
    {
      path: "/todos",
      name: "todos",
      component: () => import("../views/protected/Todos.vue"),
      meta: { requiresAuth: true },
    },
  ],
});

const { hasCurrentUser } = useUserStore()

router.beforeEach((to, from, next) => {
  if(to.matched.some(record => record.meta.requiresAuth)) {
    if(!hasCurrentUser) {
      next('/signup')
    } else {
      next()
    } 
  }
})

export default router;
