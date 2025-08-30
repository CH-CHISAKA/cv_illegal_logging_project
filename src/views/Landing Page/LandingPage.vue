
<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

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

const router = useRouter();
const currentIndex = ref(0);
const currentContent = ref(contentSections[0]);
const typedTitle = ref('');
const cursorVisible = ref(false);
let typingInterval: number | null = null;

/**
 * Simulates typing animation.
 */
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
    }, 160); // **** Typing speed in milliseconds - might adjust later to 180 to reduce the speed
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

onMounted(() => {
  cycleContent();
});

//  ======
// **** Adjust this to About Page ****
//  ======
function nextSection() {
  currentIndex.value = (currentIndex.value + 1) % contentSections.length;
  currentContent.value = contentSections[currentIndex.value];
  startTyping(currentContent.value.mainTitle);
}
</script>



<template>
  <div class="app-container">
    <!-- Navigation Bar -->
    <header class="nav-bar">
      <div id="nav-brand" @click="router.push('/')">iL</div>
      <div class="nav-icons">
        <i class="material-icons" title="Search">search</i>
        <i class="material-icons" title="Monitor" @click="router.push('/monitor')">monitor</i>
        <i class="material-icons" title="Profile">person</i>
      </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
      <section class="text-block">
        <span class="text-block-title">Monitoring Map</span>
        <h1 class="title">Map <span class="subtitle">at <span>a</span> time</span></h1>
      </section>

      <transition name="fade" mode="out-in">
        <section class="side-info" :key="currentContent.mainTitle">
          <h1 class="typed-title">
            {{ typedTitle }}<span v-if="cursorVisible" class="cursor">|</span>
          </h1>
          <h4 class="main-heading" v-html="currentContent.mainHeading"></h4>
          <h2 class="info-title" v-html="currentContent.infoTitle"></h2>
          <p class="description">{{ currentContent.description }}</p>

          <!-- ***** Adjust to About Page -->
          <button class="next-button" @click="nextSection">Next</button>
        </section>
      </transition>
    </main>

    <!-- Footer -->
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
  background: #e9f6f9; /*b3c6c9, d5e9ed */
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
  transition: color 0.3s;
}

.nav-icons i:hover {
  color: green;
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
  min-width: 250px;
}

.title {
  font-size: 2rem;
  font-weight: 600;
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
  color: #2c3e50; /** 046a1e*/
}

.cursor {
  animation: blink 1s steps(1) infinite;
  display: inline-block;
  margin-left: 5px;
}

.main-heading {
  font-size: 1.55rem;
  margin: 10px 0;
  color: #2c3e50; /* 2f2f2f*/
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

/* FOOTER */
.app-footer {
  text-align: center;
  padding: 1rem;
  background-color: #516061;
  color: white;
}

/* BUTTON */
.next-button {
  margin-top: 1rem;
  padding: 0.7rem 1.2rem;
  border: none;
  border-radius: 6px;
  background-color: #5a7f63;
  color: white;
  cursor: pointer;
  font-weight: 600;
}

.next-button:hover {
  background-color: #046a1e;
}

/* ANIMATIONS */
@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0; }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.4s;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* RESPONSIVENESS */
@media (max-width: 768px) {
  .main-content {
    flex-direction: column;
    align-items: flex-start;
  }

  .text-block,
  .side-info {
    width: 100%;
  }

  .typed-title {
    font-size: 1.8rem;
  }
}

</style>


