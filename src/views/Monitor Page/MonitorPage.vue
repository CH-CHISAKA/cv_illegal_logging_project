<!-- Monitor Page

<template>
    <div class="monitor">
        <h1>Monitor Dashboard</h1>
        <p>Here you can monitor in real-time all activities.</p>


        <!-- Camera Feed 
         <section class="video-section">
            <h2>Camera Feed</h2>
            <video>
                <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">
                Your browser does not support the video tag.
            </video>
         </section>

        <!-- Detection Results 
        <section class="results">
        <h2>Detection Results</h2>
        <ul>
            <li v-for="(item, index) in detections" :key="index">
            {{ item.label }} - Confidence: {{ item.confidence }}%
            </li>
        </ul>
        </section>

        <!-- Analytics / Charts 
        <section class="charts">
        <h2>Analytics</h2>
        <!-- Replace with chart components if already implemented 
        <p>📊 Chart placeholder (logging trends, alerts, etc.)</p>
        </section>

    </div>
</template>


<!-- Script 
<script setup lang="ts">
import { ref } from "vue";

// Example detection results (replace with live data logic)
const detections = ref([
  { label: "Chainsaw", confidence: 92 },
  { label: "Tree Falling", confidence: 85 },
]);
</script>



<!-- Styles
<style scoped>
.monitor {
  padding: 2rem;
}

.video-section, .results, .charts {
  margin-bottom: 2rem;
}

video {
  border: 2px solid #ccc;
  border-radius: 10px;
}
</style>

-->
<template>
  <div style="padding:16px" class="grid">
    <MetricsCards />

    <div class="row">
      <CameraFeed />
      <AlertsPanel />
    </div>

    <div class="row">
      <MapView />
      <SystemStatus />
    </div>
  </div>
</template>

<script setup lang="ts">
    import MetricsCards from '@/views/Monitor Page/Components/MetricsCards.vue';
    import CameraFeed from '@/views/Monitor Page/Components/CameraFeed.vue';
    import AlertsPanel from '@/views/Monitor Page/Components/AlertsPanel.vue';
    import MapView from '@/views/Monitor Page/Components/MapView.vue';
    import SystemStatus from '@/views/Monitor Page/Components/SystemStatus.vue';
</script>