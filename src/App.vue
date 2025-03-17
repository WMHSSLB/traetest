<template>
  <div class="app-container">
    <Header />
    <Carousel />
    <main class="main-content">
      <Content />
    </main>
    <Footer />
    <ChatAssistant />
  </div>
</template>

<script setup>
import Header from './components/Header.vue'
import Content from './components/Content.vue'
import Carousel from './components/Carousel.vue'
import Footer from './components/Footer.vue'
import ChatAssistant from './components/ChatAssistant.vue'
</script>

<style scoped>
.app-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.main-content {
  flex: 1;
}
.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}
.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>
