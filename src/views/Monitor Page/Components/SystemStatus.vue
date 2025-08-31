<template>
  <div class="card">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:8px">
      <h3 style="margin:0">System Status</h3>
      <button class="btn">Refresh</button>
    </div>
    <div class="grid grid-2">
      <div class="badge ok">Model: v1.4 (OK)</div>
      <div class="badge ok">GPU: 65% (OK)</div>
      <div class="badge warn">Mic 2 (Lag)</div>
      <div class="badge err">Cam 4 (Offline)</div>
    </div>
  </div>
</template>