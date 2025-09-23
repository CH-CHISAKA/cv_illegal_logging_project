

// export default router

import { createRouter, createWebHistory } from "vue-router";
import LandingPage from "@/views/landing_page/LandingPage.vue";
import AboutPage from "@/views/about_page/AboutPage.vue";



const routes = [
  { path: "/", component: LandingPage },
  { path: "/about", component: AboutPage },
  {
    path: '/login/:role',
    name: 'LoginView',
    component: () => import('@/views/landing_page/components/LoginView.vue'),
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
