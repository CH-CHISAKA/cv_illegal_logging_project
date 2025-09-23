<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import LoginView from '@/components/auth/LoginView.vue'
// import logo from 'public/assets/logo.png'

// ==================
// Content Sections
// ==================
interface Content {
  mainTitle: string
  mainHeading: string
  infoTitle: string
  description: string
}

const contentSections: Content[] = [
  {
    mainTitle: 'Illegal Logging Detection Application',
    mainHeading: '',
    infoTitle: '',
    description: '',
  },
  {
    mainTitle: 'AI-Powered Monitoring',
    mainHeading: "Preserving <span class='subtitle'>Forests</span> Future",
    infoTitle: 'About AI Monitoring',
    description: 'Our tool uses computer vision to monitor and protect forests in real time.',
  },
  {
    mainTitle: 'Sustainable Solutions',
    mainHeading: "Smart Tech <span class='subtitle'>for Green Earth</span>",
    infoTitle: 'The Vision',
    description: 'We aim to enable data-driven conservation to fight illegal logging worldwide.',
  },
  {
    mainTitle: 'Join the Effort',
    mainHeading: "Together <span class='subtitle'>We Can</span> Make a Difference",
    infoTitle: 'Get Involved',
    description:
      'This application is designed to detect and monitor illegal logging activities using advanced computer vision techniques.',
  },
  {
    mainTitle: 'Real-Time Alerts',
    mainHeading: "Stay Informed <span class='subtitle'>Instantly</span>",
    infoTitle: 'How It Works',
    description:
      'The application processes visual data to detect illegal logging patterns, providing instant notifications for swift action.',
  },
]

// ==================
// Typing Animation
// ==================
const router = useRouter()
const currentIndex = ref(0)
const currentContent = ref(contentSections[0])
const typedTitle = ref('')
const cursorVisible = ref(false)
let typingInterval: ReturnType<typeof setInterval> | null = null

function startTyping(text: string): Promise<void> {
  return new Promise((resolve) => {
    if (typingInterval) clearInterval(typingInterval)
    typedTitle.value = ''
    cursorVisible.value = true
    let index = 0

    typingInterval = setInterval(() => {
      if (index < text.length) {
        typedTitle.value += text.charAt(index)
        index++
      } else {
        clearInterval(typingInterval!)
        cursorVisible.value = false
        resolve()
      }
    }, 160)
  })
}

async function cycleContent() {
  while (true) {
    const content = contentSections[currentIndex.value]
    currentContent.value = content
    await startTyping(content.mainTitle)
    await new Promise((resolve) => setTimeout(resolve, 8000))
    currentIndex.value = (currentIndex.value + 1) % contentSections.length
  }
}

function nextSection() {
  currentIndex.value = (currentIndex.value + 1) % contentSections.length
  currentContent.value = contentSections[currentIndex.value]
  startTyping(currentContent.value.mainTitle)
}

onMounted(() => {
  cycleContent()
})

// ==================
// Profile Dropdown
// ==================

const open = ref(false)
const showLogin = ref(false)
const selectedRole = ref<string | null>(null)

function toggleDropdown() {
  open.value = !open.value
}

function openLogin(role: string) {
  selectedRole.value = role
  showLogin.value = true
  open.value = false
}

function closeLogin() {
  showLogin.value = false
}

</script>

<template>
  <div class="app-container">
    <header class="nav-bar">
      <div id="nav-brand" @click="router.push('/')">
        <img src="/assets/logo.png" alt="Logo" class="brand-logo" />
        <span class="brand-text">ILLEGAL LOGGING APPLICATION</span>
      </div>
      <div class="nav-icons">
        <i class="material-icons" id="monitor" title="Monitor" @click="router.push('/monitor')"
          >monitor</i
        >

        <!-- <i class="material-icons" id="icon-profile" title="Profile">person</i> -->

        <!-- Profile Dropdown Setup -->
        <div class="profile-dropdown">
          <button
            class="profile-btn"
            @click="toggleDropdown"
            aria-haspopup="true"
            :aria-expanded="open"
          >
             <i class="material-icons" id="icon-profile" title="Profile">person</i>
          </button>
        </div>
        <transition name="fade-scale">
          <div v-if="open" class="dropdown-card">
            <p class="menu-header">Login as</p>
            <div class="role-options">
              <button class="role-chip admin" @click="openLogin('admin')">
                <i class="material-icons">admin_panel_settings</i>
                <span>Admin</span>
              </button>
              <button class="role-chip guard" @click="openLogin('forest-guard')">
                <i class="material-icons">park</i>
                <span>Forest Guard</span>
              </button>
            </div>
          </div>
        </transition>
      </div>
    </header>

    <main class="main-content">
      <section class="text-block">
        <span class="text-block-title"> Map</span>
        <!-- Map removed -->
        <div class="map-container placeholder">
          <p style="text-align: center; color: #555">[ Map visualization removed ]</p>
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
  display: flex;
  font-size: 0.9rem;
  font-weight: lighter;
  cursor: pointer;
  font-family: 'Tahoma', sans-serif;
  align-items: center;
  gap: 5px;  
}

.brand-logo {
  height: 30px; /* adjust as needed */
  width: auto;
  display: block;
}

.nav-icons i {
  margin-left: 12px; /* reduced gap */
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

.brand-text {
  font-size: 0.65rem;
  color: #04502e;
  font-family: 'Helvetica Neue', sans-serif;
  font-weight: 320;
  white-space: nowrap;
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

/* Avatar profile button */
.profile-btn {
  border: none;
  background: none;
  cursor: pointer;
  padding: 0;
}
.avatar {
  width: 42px;
  height: 42px;
  border-radius: 50%;
  object-fit: cover;
  box-shadow: 0 2px 6px rgba(0,0,0,0.15);
  transition: transform 0.2s ease;
}
.avatar:hover {
  transform: scale(1.05);
}

/* Floating card */
.dropdown-card {
  position: absolute;
  right: 0;
  top: 55px;
  /* background: #fff; */
  background: rgb(255 255 255 / 5%);
  border-radius: 14px;
  box-shadow: 0 8px 24px rgba(0,0,0,0.18);
  padding: 1rem;
  width: 200px;
  animation: slideDown 0.25s ease-out;

}

.menu-header {
  font-size: 0.75rem;
  font-weight: 300;
  color: #777;
  margin-bottom: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-family: 'Tahoma', sans-serif;
}

/* Chips for roles */
.role-options {
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
}
.role-chip {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  padding: 0.6rem 1rem;
  border-radius: 24px;
  border: none;
  cursor: pointer;
  background: #f8fafc;
  font-size: 0.9rem;
  font-weight: 500;
  color: #222;
  transition: all 0.2s ease;
}
.role-chip i {
  font-size: 18px;
}
.role-chip:hover {
  background: #ecfdf5;
  color: #047857;
  transform: translateX(2px);
}

/* Role-specific accents */
.role-chip.admin i { color: #1e3a8a; }
.role-chip.guard i { color: #047857; }

/* Fade + scale */
.fade-scale-enter-active,
.fade-scale-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}
.fade-scale-enter-from,
.fade-scale-leave-to {
  opacity: 0;
  transform: scale(0.95);
}

@keyframes slideDown {
  from { transform: translateY(-6px); opacity: 0; }
  to   { transform: translateY(0); opacity: 1; }
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
  font-size: 4.37rem;
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
  font-size: 1.2rem;
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

/* BUTTON */
.next-button {
  background-color: #333;
  border: none;
  color: white;
  font-size: 1rem;
  padding: 10px 20px;
  cursor: pointer;
  border-radius: 24px;
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
