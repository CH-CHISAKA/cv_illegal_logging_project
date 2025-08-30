// import { createRouter, createWebHistory } from 'vue-router'
// import Home from '@/App.vue'        // your landing page
// import Monitor from '@/views/monitor.vue'  // your monitoring dashboard

// const router = createRouter({
//   history: createWebHistory(import.meta.env.BASE_URL),
//   routes: [
//     { path: '/', component: Home },
//     { path: '/monitor', component: Monitor},
//   ],
// })



// export default router

import { createRouter, createWebHistory } from "vue-router";
import LandingPage from "@/views/Landing Page/LandingPage.vue";
import MonitorPage from "@/views/Monitor Page/MonitorPage.vue";
import AboutPage from "@/views/About Page/AboutPage.vue";

const routes = [
  { path: "/", component: LandingPage },
  { path: "/monitor", component: MonitorPage },
  { path: "/about", component: AboutPage },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
