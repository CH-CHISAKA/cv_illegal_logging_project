<template>
  <aside class="sidebar">
    <div class="logo">ForestGuard</div>
    <div class="nav" style="margin-top:12px">
      <router-link to="/" :class="linkClass('/')">Home</router-link>
      <router-link to="/monitor" :class="linkClass('/monitor')">Monitor</router-link>
      <router-link to="/about" :class="linkClass('/about')">About</router-link>
    </div>

    <div style="margin-top:16px" class="grid">
      <div class="badge ok">System: Online</div>
      <div class="badge">Cameras: 4</div>
      <div class="badge">Mics: 2</div>
    </div>
  </aside>
</template>

<script setup lang="ts">
import { useRoute } from 'vue-router'
const route = useRoute()
const linkClass = (path: string) => (route.path === path ? 'active' : '')
</script>