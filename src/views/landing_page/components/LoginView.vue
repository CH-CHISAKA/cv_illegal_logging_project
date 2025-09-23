

<script setup lang="ts">
import { ref } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const roleParam = route.params.role;
const role = Array.isArray(roleParam) ? roleParam[0] : roleParam; // Ensure role is a string

const username = ref('');
const password = ref('');

function handleLogin() {
  // Dummy auth logic
  if (username.value && password.value) {
    alert(`Logging in as ${role}`);
    // Add real auth logic here...
  }
}
</script>

<template>
  <div class="login-container">
    <h2 class="login-title">Login as {{ role.replace('-', ' ') }}</h2>
    <div class="login-form">
      <input v-model="username" placeholder="Username" class="input-field" />
      <input v-model="password" type="password" placeholder="Password" class="input-field" />
      <button @click="handleLogin" class="login-button">LOGIN</button>
    </div>
  </div>
</template>

<style scoped>
.login-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 10vh;
  padding: 2rem;
  background-color: #012f34;
  border-radius: 8px;
  width: 350px;
  margin-left: auto;
  margin-right: auto;
}

.login-title {
  color: white;
  font-size: 1.5rem;
  margin-bottom: 1.5rem;
  text-transform: capitalize;
}

.login-form {
  width: 100%;
}

.input-field {
  width: 100%;
  padding: 12px;
  margin-bottom: 1rem;
  border-radius: 8px;
  border: none;
  background-color: #f5f5f5;
}

.login-button {
  width: 100%;
  padding: 12px;
  background-color: white;
  color: #012f34;
  border: none;
  border-radius: 8px;
  font-weight: bold;
  cursor: pointer;
  transition: background-color 0.3s;
}

.login-button:hover {
  background-color: #04502e;
  color: white;
}
</style>
