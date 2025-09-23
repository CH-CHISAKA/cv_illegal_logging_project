<script setup lang="ts">
import { ref, onMounted } from 'vue';
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

onMounted(() => {
  cycleContent();
});

const showDropdown = ref(false);

function toggleDropdown() {
  showDropdown.value = !showDropdown.value;
}

function selectRole(role: string) {
  showDropdown.value = false;
  router.push(`/login/${role}`);
}

</script>

<template>
  <div class="app-container">
    <header class="nav-bar">
      <div id="nav-brand" @click="router.push('/')"> </div>
      <div class="nav-icons">
        <i class="material-icons" id="monitor" title="Monitor" @click="router.push('/monitor')">monitor</i>
        
        
        <!-- Profile Dropdown -->
        <div class="dropdown-wrapper" @mouseleave="showDropdown = false">
          <i class="material-icons" id="icon-profile" title="Profile" @click="toggleDropdown">person</i>
          <ul v-if="showDropdown" class="dropdown-menu">
            <li @click="selectRole('forest-guard')">Forest Guard</li>
            <li @click="selectRole('admin')">Admin</li>
          </ul>
        </div>
      </div>
    </header>

    <main class="main-content">
      <section class="text-block">
        <span class="text-block-title"> Map</span>
        <!-- Map removed -->
        <div class="map-container placeholder">
          <p style="text-align:center; color:#555;">[ Map visualization removed ]</p>
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
  margin-left: 12px;              /* reduced gap */
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

.nav-icons i:hover::after {
  width: 100%; /* animate to full width on hover */
}

.nav-icons {
  display: flex;
  justify-content: flex-start; /* Push icons to the left */
  gap: 24px; /* Increase spacing between icons */
  padding-right: 22px; /* Add some right padding */
}

.nav-icons i {
  cursor: pointer;
  position: relative;
  padding-bottom: 4px;
  transition: color 0.3s;
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
  height: 500px;
  width: 100%;
  min-width: 250px;
  position: relative;
}

.map-container {
  height: 400px;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px dashed #ccc;
  border-radius: 8px;
  background-color: #fafafa;
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
  font-weight: lighter;
  margin-bottom: 0.5rem;
  color: #04502e;
  font-family: 'Tahoma', sans-serif;
}

.cursor {
  animation: blink 1s steps(1) infinite;
  display: inline-block;
  margin-left: 5px;
}

.main-heading {
  font-size: 1.20rem;
  margin: 10px 0;
  color: #2c3e50;
  font-family: 'Tahoma', sans-serif;
  font-weight: 550;
}

.info-title {
  font-size: 1.1rem;
  color: #5a7f63;
  font-family: 'Tahoma', sans-serif;
  font-weight: 500;
  margin-bottom: 0.5rem;
}

.description {
  font-size: 0.8rem;
  color: #333;
  font-family: 'Tahoma', sans-serif;
  font-weight: 300;
}


.dropdown-wrapper {
  position: relative;
  display: inline-block;
}

.dropdown-menu {
  position: absolute;
  top: 32px;
  right: 0;
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
  min-width: 150px;
  box-shadow: 0px 3px 6px rgba(0,0,0,0.1);
  z-index: 1000;
}

.dropdown-menu li {
  list-style: none;
  padding: 10px 16px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.dropdown-menu li:hover {
  background-color: #04502e;
  color: white;
}
.dropdown-wrapper {
  position: relative;
  display: inline-block;
}

.dropdown-menu {
  position: absolute;
  top: 32px;
  right: 0;
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
  min-width: 150px;
  box-shadow: 0px 3px 6px rgba(0,0,0,0.1);
  z-index: 1000;
}

.dropdown-menu li {
  list-style: none;
  padding: 10px 16px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.dropdown-menu li:hover {
  background-color: #04502e;
  color: white;
}

/* BUTTON */
.next-button {
  background-color: #333;
  border: none;
  color: white;
  font-size: 1rem;
  padding: 10px 20px;
  cursor: pointer;
  border-radius: 5px;
  margin-top: 20px;
}

.next-button:hover {
  background-color: #04502e; 
}

.app-footer {
  padding: 1rem 2rem;
  text-align: center;
  background-color: #f0f8ff;
}
</style>
