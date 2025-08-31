<template>
  <header class="header">
    <div style="display:flex; gap:8px; align-items:center">
      <button class="btn">⟳ Refresh</button>
      <button class="btn">▶ Start</button>
      <button class="btn">■ Stop</button>
      <button class="btn">⚙ Settings</button>
    </div>

    <div class="search">
      <input placeholder="Search cameras, alerts, zones..." />
    </div>

    <div style="display:flex; gap:8px; align-items:center">
      <span class="badge ok">Healthy</span>
      <span class="badge warn">2 Warnings</span>
      <span class="badge err">1 Critical</span>
    </div>
  </header>
</template>

<script setup lang="ts">
</script>