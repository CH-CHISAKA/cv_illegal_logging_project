<script setup lang="ts">
import { ref } from 'vue';

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
    description:""
  },
  {
    mainTitle: "AI-Powered Monitoring",
    mainHeading: "Preserving <span class='subtitle'>Forests </span> Future",
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
    description: "This application is designed to detect and monitor illegal logging activities using advanced computer vision techniques. By analyzing images and videos captured from various sources, the system can identify signs of unauthorized tree cutting and alert relevant authorities in real-time."
  },
  {
    mainTitle: "Real-Time Alerts",
    mainHeading: "Stay Informed <span class='subtitle'>Instantly</span>",
    infoTitle: "How It Works",
    description: "The application processes visual data to detect illegal logging patterns, providing instant notifications to forest management teams for swift action."
  }
];

const currentIndex = ref(0);
const currentContent = ref<Content>(contentSections[0]);

const typedTitle = ref('');
const cursorVisible = ref(false);

let typingInterval: number | null = null;

/**
 * Simulate typing letter-by-letter.
 */
function startTyping(text: string): Promise<void> {
  return new Promise((resolve) => {
    if (typingInterval) clearInterval(typingInterval);

    typedTitle.value = '';
    cursorVisible.value = true; // Show cursor at start of typing
    let index = 0;

    typingInterval = setInterval(() => {
      if (index < text.length) {
        typedTitle.value += text.charAt(index);
        index++;
      } else {
        clearInterval(typingInterval!);
        cursorVisible.value = false; // Hide cursor after typing completes
        resolve();
      }
    }, 180); // Typing speed (ms per character)
  });
}

/**
 * Loop through sections, wait for typing to finish, then pause.
 */
async function cycleContent() {
  while (true) {
    const content = contentSections[currentIndex.value];
    currentContent.value = content;

    await startTyping(content.mainTitle);

    // ⏸ Pause after typing finishes (e.g. 9 seconds)
    await new Promise(resolve => setTimeout(resolve, 9000));

    currentIndex.value = (currentIndex.value + 1) % contentSections.length;
  }
}

// Start cycle on mount
cycleContent();
</script>

<template>
  <div class="app-container">
    <!-- NAVIGATION BAR -->
    <header class="nav-bar">
      <div id="nav-brand">iL</div>
      <div class="nav-icons">
        <i class="material-icons" id="icon-search" style="padding-right: 150px; position: relative; top: 5px;">search</i>
        <i class="material-icons" id="monitor" title="Monitor" style="margin-right: 30px;">monitor</i>
        <i class="material-icons" id="icon-profile" title="Profile" style="margin-left: 5px;">person</i>
      </div>
    </header>

    <!-- MAIN CONTENT SECTION -->
    <main class="main-content">
      <div class="text-block">
        <span class="text-block-title">Monitoring Map</span>
        <h1 class="title">
          Map <span class="subtitle">at <span>a</span> time</span>
        </h1>
      </div>

      <!-- SIDE INFO -->
      <transition name="fade" mode="out-in">
        <div class="side-info" :key="currentContent.mainTitle">
          <div>
            <!-- <h1 class="text-block-title typed-title" style="font-size: 70px;">{{ typedTitle }} </h1> -->
            <h1 class="text-block-title typed-title" style="font-size: 70px;">
  {{ typedTitle }}<span v-if="cursorVisible" class="cursor">|</span>
</h1>
            <h4 class="title" v-html="currentContent.mainHeading" style="color: #2f2f2f;"></h4>
          </div>

          <h2 class="side-info-title" v-html="currentContent.infoTitle" style="color: #5a7f63;"></h2>
          <p class="side-info-description" style="color: #2f2f2f;">
            {{ currentContent.description }}
          </p>
        </div>
      </transition>
    </main>

    <footer class="app-footer">
      <p>&copy; 2025 Illegal Logging Detection. All rights reserved.</p>
    </footer>
  </div>
</template>

<style scoped>
/* == APP CONTAINER STYLES == */
.app-container {
  display: flex;
  flex-direction: column;
  margin: 0;
  padding: 0;
  width: 100%;
  min-height: 100dvh;
  justify-content: center;
  background: linear-gradient(360deg, #b0c4de, #f0f8ff);
}

#nav-brand {
  font-size: 1.1rem;
  font-weight: bolder;
  color: #000;
  padding: 18px 16px;
  cursor: pointer;
  font-family: 'Helvetica', 'Arial', sans-serif;
}

/* == NAVIGATION BAR == */
.nav-bar {
  color: rgb(83, 79, 79);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.nav-icons {
  padding: 20px 45px;
}

.nav-icons i {
  margin-left: 16px;
  cursor: pointer;
  position: relative;
  display: inline-block;
  padding-bottom: 4px;
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

#icon-menu:hover::after,
#icon-profile:hover::after,
#monitor:hover::after {
  width: 100%;
}

/* == MAIN CONTENT == */
.main-content {
  flex: 1;
  padding: 16px;
  display: flex;
  height: calc(100vh - 64px);
  align-items: center;
  justify-content: space-between;
}

.text-block {
  flex: 2;
}

.title {
  font-size: 24px;
  font-weight: bold;
}

.subtitle {
  font-size: 18px;
  color: #666;
}


/* == SIDE INFO == */
.side-info {
  flex: 1;
  padding: 12px;
  margin-left: 16px;
  color: rgb(60, 134, 21);
  font-family: 'Arial', sans-serif;
}

.side-info-title {
  font-weight: bold;
}

/* == TYPING EFFECT STYLING == */
/* .typed-title::after {
  content: '|';
  animation: blink 1s infinite;
  margin-left: 5px;
} */

.cursor {
  display: inline-block;
  margin-left: 5px;
  animation: blink 1s steps(1) infinite;
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0; }
}

/* 
@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0; }
} */

/* == FADE TRANSITION == */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* == FOOTER == */
.app-footer {
  color: white;
  text-align: center;
  padding: 12px 16px;
}
</style>
