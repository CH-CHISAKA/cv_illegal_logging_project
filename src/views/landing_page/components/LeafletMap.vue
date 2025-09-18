


<template>
  <!-- Attach a fixed height here -->
  <LMap
    :zoom="13"
    :center="[51.505, -0.09]"
    class="leaflet-map"
  >
    <LTileLayer :url="tileLayerUrl" />

    <!-- Dynamically render LMarker components -->
    <LMarker
      v-for="(marker, index) in markers"
      :key="index"
      :lat-lng="[marker.lat, marker.lng]"
      @click="handleMarkerClick(marker)"
    >
      <template #popup>
        <div>
          <strong>Logging Activity</strong><br />
          Lat: {{ marker.lat }}<br />
          Lng: {{ marker.lng }}
        </div>
      </template>
    </LMarker>
  </LMap>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { LMap, LTileLayer, LMarker } from '@vue-leaflet/vue-leaflet';

const tileLayerUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';

interface MarkerData {
  lat: number;
  lng: number;
}

const markers = ref<MarkerData[]>([]);

onMounted(() => {
  const socket = new WebSocket('ws://localhost:8080');

  socket.onmessage = (event) => {
    const data = JSON.parse(event.data);
    console.log('Received data:', data);

    const { lat, lng } = data;

    markers.value.push({ lat, lng });
  };

  socket.onclose = () => {
    console.log('WebSocket connection closed');
  };
});

const handleMarkerClick = (marker: MarkerData) => {
  console.log('Marker clicked:', marker);
};
</script>

<style scoped>
/* This ensures the map is visible */
.leaflet-map {
  height: 400px; /* 👈 give it a fixed height */
  width: 100%;
}
</style>
