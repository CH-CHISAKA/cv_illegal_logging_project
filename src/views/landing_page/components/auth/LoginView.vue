

<template>
  <div class="login-overlay" @click.self="$emit('close')">
    <div class="login-modal">
      <h1>Login</h1>
      <p class="welcome-text">Welcome back please login to your account</p>

      <form @submit.prevent="handleLogin" class="login-form">
        <div class="input-group">
          <input
            type="text"
            placeholder="User Name"
            v-model="username"
            autocomplete="username"
            required
          />
          <span class="icon material-icons">person</span>
        </div>

        <div class="input-group">
          <input
            :type="showPassword ? 'text' : 'password'"
            placeholder="Password"
            v-model="password"
            autocomplete="current-password"
            required
          />
          <span
            class="icon material-icons toggle-password"
            @click="togglePasswordVisibility"
            :title="showPassword ? 'Hide Password' : 'Show Password'"
            >{{ showPassword ? 'visibility_off' : 'visibility' }}</span
          >
        </div>

        <label class="remember-me">
          <input type="checkbox" v-model="rememberMe" />
          <span class="checkmark">✔</span>
          Remember me
        </label>

        <button type="submit" class="login-btn">Login</button>
      </form>

      <p class="signup-text">
        Do not have an account?
        <strong @click="openSignup">Signup</strong>
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const props = defineProps<{ role: string | null }>()
const emit = defineEmits<{
  (e: 'close'): void
  (e: 'open-signup'): void
}>()

const router = useRouter()

const username = ref('')
const password = ref('')
const rememberMe = ref(true)
const showPassword = ref(false)
const showSignup = ref(false)

function togglePasswordVisibility() {
  showPassword.value = !showPassword.value
}

function handleLogin() {
  if (!username.value || !password.value) {
    alert('Please enter your username and password.')
    return
  }
  // For demo: save session with role, username, and rememberMe flag
  sessionStorage.setItem(
    'iluser',
    JSON.stringify({
      role: props.role ?? 'user',
      username: username.value,
      rememberMe: rememberMe.value,
    }),
  )
  alert('Logged in as ' + (props.role ?? 'User'))
  emit('close')
}

// =================
// Open signup modal
// ================
function openSignup() {
  // showSignup.value = true
  emit('open-signup')
  emit('close')
}

</script>

<style scoped>
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');




.login-overlay {
  position: fixed;
  inset: 0;
  /* background: rgba(255 255 255 / 0.2);
  backdrop-filter: blur(10px); */
  /**background: rgba(0, 0, 0, 0.2); /* Optional */
  display: flex;
  align-items: center;       /* vertically center */
  justify-content: flex-end;  /* align modal to right */
  z-index: 9999;
  padding: 1rem;
  overflow: hidden;          /* prevent scrolling issues */
}

.login-modal {
  background: rgba(255 255 255 / 0.15);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 2.5rem 2rem 3rem;
  width: 350px;
  /* height: 50vh;  */
  max-width: 90vw;
  box-shadow: 0 8px 40px rgb(3 103 4 / 0.3);
  border: 1px solid rgba(255 255 255 / 0.3);
  color: #fff;
  font-family: 'Tahoma', sans-serif;
  user-select: none;
  display: flex;
  flex-direction: column;
  overflow-y: auto;             /* scroll inside if content too tall */
  gap: 0.5rem;
}

.login-modal h1 {
  font-weight: lighter;
  font-size: 2rem;
  margin-bottom: 0.25rem;
  color: #4a4c4b; /* Bright white for better contrast */
  user-select: text;
  font-family: 'Tahoma', sans-serif;
}

.login-modal p {
  font-weight: 400;
  font-size: 0.95rem;
  margin-bottom: 1.5rem;
  color: #6d6666; /**6b6a6a */
  user-select: text;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.input-group {
  position: relative;
  width: 100%;
}

.input-group input {
  width: 80%;
  padding: 0.75rem 3rem 0.75rem 1rem;
  border-radius: 12px;
  border: 1.5px solid rgba(255 255 255 / 0.7);
  background: rgba(255 255 255 / 0.15);
  color: #161515;
  font-size: 1rem;
  font-weight: 400;
  outline-offset: 2px;
  outline-color: transparent;
  transition: outline-color 0.25s ease;
  /* caret-color: #6ade4f; */
  outline-color: transparent;
}

.input-group input::placeholder {
  color: #6a6969;
  font-weight: 300;
}

.input-group input:focus {
  outline-color: #43a72d;
  /* border-color: #6ade4f; */
  background: rgba(255 255 255 / 0.3);
  outline-width: 1px;
}

.icon {
  position: absolute;
  right: 0.85rem;
  top: 50%;
  transform: translateY(-50%);
  font-size: 1.4rem;
  color: #a3a3a3;
  cursor: default;
  user-select: none;
  transition: color 0.3s ease;
}



.toggle-password {
  cursor: pointer;
}

.toggle-password:hover {
  color: #6ade4f;
}

/* Checkbox styling for "Remember me" */
.remember-me {
  display: flex;
  align-items: center;
  font-size: 0.9rem;
  font-weight: 400;
  gap: 0.5rem;
  cursor: pointer;
  user-select: none;
  color: #717070;
  user-select: text;
  position: relative;
  padding-left: 26px;
  user-select: none;
}

/* Native checkbox — slightly visible and styled */
.remember-me input[type="checkbox"] {
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 18px;
  height: 18px;
  border: 2px solid #333;
  border-radius: 4px;
  background-color: white;
  opacity: 0.4; /* <- makes it slightly visible */
  appearance: none;
  -webkit-appearance: none;
  cursor: pointer;
  z-index: 1; /* Ensure it's under the checkmark */
}

.remember-me input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 18px;
  width: 18px;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  margin: 0;
}

.checkmark {
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  height: 18px;
  width: 18px;
  border-radius: 4px;
  background: #6ade4f;
  box-shadow: 0 1px 5px #3e7436;
  color: white;
  font-size: 14px;
  font-weight: bold;
  line-height: 1;
  text-align: center;
  user-select: none;
  pointer-events: none;
  transition: background 0.3s ease;
  opacity: 0;
  z-index: 2; /* On top of checkbox */
}

.remember-me input:checked + .checkmark {
  opacity: 1;
}

/* Login button */
.login-btn {
  padding: 0.9rem 1rem;
  border-radius: 24px;
  border: none;
  background: #8e8f8e;
  color: white;
  font-weight: 700;
  font-size: 1.15rem;
  cursor: pointer;
  transition: background 0.3s ease;
  user-select: none;
}

.login-btn:hover {
  background: #219008;
}

/* Signup text */
.signup-text {
  font-size: 0.8rem;
  margin-top: 1.4rem;
  color: #504f4e !important;
  user-select: text;
}

.signup-text strong {
  cursor: pointer;
  font-weight: 300;
  color: #717070;
  user-select: none;
  transition: color 0.3s ease;
  font-family: 'Tahoma', sans-serif;
}

.signup-text strong:hover {
  color: #219008;
}

/* Creator text */
.creator-text {
  margin-top: 2rem;
  font-size: 0.75rem;
  color: #252323 !important;
  text-align: center;
  font-weight: 300;
  user-select: text;
  font-style: italic;
}

.creator-text em{
  font-family: 'Tahoma', sans-serif;
  color: #252323;
}

/* Responsive */
@media (max-width: 400px) {
  .login-modal {
    width: 100%;
    padding: 2rem 1.5rem 2.5rem;
  }
}
</style>

<!-- Adjust text next to sign up -->