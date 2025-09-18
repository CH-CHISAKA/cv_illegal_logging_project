<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { LMap, LTileLayer, LMarker } from '@vue-leaflet/vue-leaflet';
import LeafletMap from "@/views/landing_page/components/LeafletMap.vue";
import { useRouter } from 'vue-router';

// ==================
// Content Sections
// ==================
interface Content {
  mainTitle: string;
  mainHeading: string;
  infoTitle: string;
  description: string;
}

const contentSections: Content[] = [
  {
    mainTitle: "Illegal Logging Detection Application",
    mainHeading: "",
    infoTitle: "",
    description: ""
  },
  {
    mainTitle: "AI-Powered Monitoring",
    mainHeading: "Preserving <span class='subtitle'>Forests</span> Future",
    infoTitle: "About AI Monitoring",
    description: "Our tool uses computer vision to monitor and protect forests in real time."
  },
  {
    mainTitle: "Sustainable Solutions",
    mainHeading: "Smart Tech <span class='subtitle'>for Green Earth</span>",
    infoTitle: "The Vision",
    description: "We aim to enable data-driven conservation to fight illegal logging worldwide."
  },
  {
    mainTitle: "Join the Effort",
    mainHeading: "Together <span class='subtitle'>We Can</span> Make a Difference",
    infoTitle: "Get Involved",
    description: "This application is designed to detect and monitor illegal logging activities using advanced computer vision techniques."
  },
  {
    mainTitle: "Real-Time Alerts",
    mainHeading: "Stay Informed <span class='subtitle'>Instantly</span>",
    infoTitle: "How It Works",
    description: "The application processes visual data to detect illegal logging patterns, providing instant notifications for swift action."
  }
];

// ==================
// Typing Animation
// ==================
const router = useRouter();
const currentIndex = ref(0);
const currentContent = ref(contentSections[0]);
const typedTitle = ref('');
const cursorVisible = ref(false);
let typingInterval: ReturnType<typeof setInterval> | null = null;

function startTyping(text: string): Promise<void> {
  return new Promise((resolve) => {
    if (typingInterval) clearInterval(typingInterval);
    typedTitle.value = '';
    cursorVisible.value = true;
    let index = 0;

    typingInterval = setInterval(() => {
      if (index < text.length) {
        typedTitle.value += text.charAt(index);
        index++;
      } else {
        clearInterval(typingInterval!);
        cursorVisible.value = false;
        resolve();
      }
    }, 160);
  });
}

async function cycleContent() {
  while (true) {
    const content = contentSections[currentIndex.value];
    currentContent.value = content;
    await startTyping(content.mainTitle);
    await new Promise(resolve => setTimeout(resolve, 8000));
    currentIndex.value = (currentIndex.value + 1) % contentSections.length;
  }
}

function nextSection() {
  currentIndex.value = (currentIndex.value + 1) % contentSections.length;
  currentContent.value = contentSections[currentIndex.value];
  startTyping(currentContent.value.mainTitle);
}

// ==================
// WebSocket + Map
// ==================
const tileLayerUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';

interface MarkerData {
  lat: number;
  lng: number;
}

const markers = ref<MarkerData[]>([]);

onMounted(() => {
  cycleContent();

  const socket = new WebSocket('ws://localhost:8080');  // Replace with your server URL

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

<template>
  <div class="app-container">
    <header class="nav-bar">
      <div id="nav-brand" @click="router.push('/')"> </div>
      <div class="nav-icons">
        <i class="material-icons" id="icon-search" title="Search">search</i>
        <i class="material-icons" id="monitor" title="Monitor" @click="router.push('/monitor')">monitor</i>
        <i class="material-icons" id="icon-profile" title="Profile">person</i>
      </div>
    </header>

    <main class="main-content">
      <section class="text-block">
        <span class="text-block-title">Monitoring Map</span>
        <!-- Render map directly -->
        <div class="map-container">
          <LeafletMap />
        </div>
      </section>

      <transition name="fade" mode="out-in">
        <section class="side-info" :key="currentContent.mainTitle">
          <h1 class="typed-title">
            {{ typedTitle }}<span v-if="cursorVisible" class="cursor">|</span>
          </h1>
          <h4 class="main-heading" v-html="currentContent.mainHeading"></h4>
          <h2 class="info-title" v-html="currentContent.infoTitle"></h2>
          <p class="description">{{ currentContent.description }}</p>

          <button class="next-button" @click="nextSection">Learn More 🌐</button>
        </section>
      </transition>


    </main>

    <footer class="app-footer">
      <p>&copy; 2025 Illegal Logging Detection. All rights reserved.</p>
    </footer>
  </div>
</template>

<style scoped>
  /* LAYOUT */
.app-container {
  display: flex;
  flex-direction: column;
  min-height: 100dvh;
  background: linear-gradient(360deg, #b0c4de, #f0f8ff);
}

/* NAVIGATION BAR */
.nav-bar {
  display: flex;
  justify-content: space-between;
  padding: 12px 24px;
  box-shadow: 0 1px 6px rgba(0, 0, 0, 0.1);
}

#nav-brand {
  font-size: 1.3rem;
  font-weight: bold;
  cursor: pointer;
  font-family: 'Helvetica', sans-serif;
}

.nav-icons i {
  margin-left: 16px;
  cursor: pointer;
  position: relative;
  display: inline-block;
  padding-bottom: 4px;
  transition: color 0.3s;
}

.nav-icons i:hover {
  color: green;
}

.nav-icons i::after {
 content: '';
 position: absolute;
 left: 50%;
 transform: translateX(-50%);
 bottom: 0;
 height: 2px;
 width: 0;
 background-color: green;
 transition: width 0.3s ease-in-out;
}

#icon-search:hover::after,
#icon-profile:hover::after,
#monitor:hover::after {
  width: 100%;
}


/* MAIN CONTENT */
.main-content {
  flex: 1;
  display: flex;
  padding: 2rem;
  gap: 2rem;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
}

.text-block {
  flex: 1;
  height: 500px; /* or 100vh */
  width: 100%;
  min-width: 250px;
  position: relative;
}

.map-container {
  height: 400px;
  width: 100%;
}

/* Optional: style for your map inside LandingPage */
.text-block .container-map {
  margin-top: 1rem;
  height: 400px; /* you can tweak */
  width: 100%;
}


.subtitle {
  font-size: 1.3rem;
  color: #333;
}

/* SIDE INFO */
.side-info {
  flex: 1;
  min-width: 250px;
  color: #2f2f2f;
}

.typed-title {
  font-size: 4.370rem;
  font-weight: bold;
  margin-bottom: 0.5rem;
  color: #04502e; /**  2c3e50  046a1e*/
}

.cursor {
  animation: blink 1s steps(1) infinite;
  display: inline-block;
  margin-left: 5px;
}

.main-heading {
  font-size: 1.55rem;
  margin: 10px 0;
  color: #2c3e50;
}

.info-title {
  font-size: 1.2rem;
  color: #5a7f63;

  margin-bottom: 0.5rem;
}

.description {
  font-size: 1rem;
  color: #333;
}

/* BUTTON */
.next-button {
  background-color: #04502e;
  border: none;
  color: white;
  font-size: 1rem;
  padding: 10px 20px;
  cursor: pointer;
  border-radius: 5px;
  margin-top: 20px;
}

.next-button:hover {
  background-color: #333;
}

.app-footer {
  padding: 1rem 2rem;
  text-align: center;
  background-color: #f0f8ff;
}

.map-container {
  height: 100%;
  width: 100%;
}
</style>
