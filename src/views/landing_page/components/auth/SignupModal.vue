

<template>
  <div class="signup-overlay" @click.self="$emit('close')">
    <div class="signup-modal">
      <h1>Signup</h1>
      <p class="welcome-text">Create a new account</p>

      <form @submit.prevent="handleSignup" class="signup-form">
        <div class="input-group">
          <input
            type="text"
            placeholder="Username"
            v-model="username"
            autocomplete="username"
            required
          />
          <span class="icon material-icons">person</span>
        </div>

        <div class="input-group">
          <input
            type="email"
            placeholder="Email"
            v-model="email"
            autocomplete="email"
            required
          />
          <span class="icon material-icons">email</span>
        </div>

        <div class="input-group">
          <input
            :type="showPassword ? 'text' : 'password'"
            placeholder="Password"
            v-model="password"
            autocomplete="new-password"
            required
          />
          <span
            class="icon material-icons toggle-password"
            @click="togglePasswordVisibility"
            >{{ showPassword ? 'visibility_off' : 'visibility' }}</span
          >
        </div>

        <div class="input-group">
          <input
            :type="showPassword ? 'text' : 'password'"
            placeholder="Confirm Password"
            v-model="confirmPassword"
            autocomplete="new-password"
            required
          />
          <span class="icon material-icons">lock</span>
        </div>

        <button type="submit" class="signup-btn">Create Account</button>
      </form>

      <p class="login-text">
        Already have an account?
         <strong @click="goToLogin">Login</strong>
      </p>
    </div>
  </div>

</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const emit = defineEmits(['close', 'open-login'])
const router = useRouter()

const username = ref('')
const email = ref('')
const password = ref('')
const confirmPassword = ref('')
const showPassword = ref(false)

function togglePasswordVisibility() {
  showPassword.value = !showPassword.value
}

function handleSignup() {
  if (!username.value || !email.value || !password.value || !confirmPassword.value) {
    alert('Please fill in all fields.')
    return
  }

  if (password.value !== confirmPassword.value) {
    alert('Passwords do not match.')
    return
  }

  alert(`Account created for ${username.value}`)
  emit('close')
}

// ================
// Routing to login
// ================
function goToLogin() {
  emit('close')
  emit('open-login')
}

</script>

<style scoped>
.signup-overlay {
  position: fixed;
  inset: 0;
  /*background: rgba(0, 0, 0, 0.2); /* optional dim */
  display: flex;
  align-items: center;
  justify-content: flex-end;
  z-index: 9999;
  padding: 1rem;
}

.signup-modal {
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 2.5rem 2rem 3rem;
  width: 350px;
  max-width: 90vw;
  box-shadow: 0 8px 40px rgb(3 103 4 / 0.3);
  border: 1px solid rgba(255, 255, 255, 0.3);
  color: #333;
  font-family: 'Tahoma', sans-serif;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
  gap: 0.5rem;
}

.signup-modal h1 {
  font-weight: lighter;
  font-size: 2rem;
  margin-bottom: 0.25rem;
  color: #4a4c4b;
}

.signup-modal p {
  font-weight: 400;
  font-size: 0.95rem;
  margin-bottom: 1.5rem;
  color: #6d6666;
}

.signup-form {
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
  border: 1.5px solid rgba(255, 255, 255, 0.7);
  background: rgba(255, 255, 255, 0.15);
  color: #161515;
  font-size: 1rem;
  font-weight: 400;
  outline-offset: 2px;
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
  /*border-color: #6ade4f; */
  background: rgba(255, 255, 255, 0.3);
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

.signup-btn {
  padding: 0.9rem 1rem;
  border-radius: 24px;
  border: none;
  background: #8e8f8e;
  color: white;
  font-weight: 700;
  font-size: 1.15rem;
  cursor: pointer;
  transition: background 0.3s ease;
}

.signup-btn:hover {
  background: #219008;
}

/* Login redirect text */
.login-text {
  font-size: 0.85rem;
  margin-top: 1.4rem;
  /* color: #504f4e; */
  color: #504f4e !important;
  text-align: left;
}

.login-text strong {
  cursor: pointer;
  font-weight: 300;
  color: #717070;
  user-select: none;
  transition: color 0.3s ease;
}

.login-text strong:hover {
  color: #219008;
}

@media (max-width: 400px) {
  .signup-modal {
    width: 100%;
    padding: 2rem 1.5rem 2.5rem;
  }
}
</style>


<!-- Adjust routing back to log in -->