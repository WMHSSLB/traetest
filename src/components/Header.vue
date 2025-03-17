<template>
  <header class="app-header">
    <div class="brand">
      <div class="title-wrapper">
  <h1>{{ siteTitle }}</h1>
  <div class="subtitle">{{ subTitle }}</div>
</div>
    </div>
    <nav class="nav-links">
      <router-link to="/">首页</router-link>
      <router-link to="/about">关于</router-link>
      <router-link to="/portfolio">作品集</router-link>
      <router-link to="/contact">联系</router-link>
    </nav>
  </header>
</template>

<script setup>
const siteTitle = '个人简介';
const subTitle = '设计师 · 全栈开发者';
</script>

<style scoped>
.app-header {
  display: flex;
  justify-content: space-between;
  padding: 1rem 2rem;
  background-color: var(--primary-color);
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.brand h1 {
  color: var(--text-light);
  margin: 0;
}

.nav-links {
  display: flex;
  gap: 2rem;
  align-items: center;
}

.nav-links a {
  color: var(--text-light);
  text-decoration: none;
  transition: opacity 0.3s;
}

.nav-links a:hover {
  opacity: 0.8;
}

@media (max-width: 768px) {
  .app-header {
    flex-direction: column;
    align-items: center;
    padding: 1rem;
  }
  
  .nav-links {
    margin-top: 1rem;
    gap: 1.5rem;
  }
}
</style>