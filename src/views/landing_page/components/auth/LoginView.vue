



<template>
  <div class="login-overlay">
    <div class="login-modal">
      <button class="close-btn" @click="$emit('close')">×</button>
      <h2>{{ role.toUpperCase() }} LOGIN</h2>

      <!-- Your existing form -->
      <div class="form-wrap">
        <!-- ... username/password fields ... -->
        <button class="login-btn" @click="handleLogin">LOGIN</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const props = defineProps<{ role: string }>()
const emit = defineEmits(['close'])

const username = ref('')
const password = ref('')

function handleLogin() {
  if (!username.value || !password.value) {
    alert('Enter credentials')
    return
  }
  sessionStorage.setItem('iluser', JSON.stringify({ role: props.role, username: username.value }))
  alert('Logged in as ' + props.role)
  emit('close')
}
</script>

<style scoped>
.login-overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}
.login-modal {
  background: #fff;
  padding: 2rem;
  border-radius: 12px;
  width: 360px;
  position: relative;
}
.close-btn {
  position: absolute;
  right: 10px;
  top: 10px;
  border: none;
  background: transparent;
  font-size: 20px;
  cursor: pointer;
}
</style>
