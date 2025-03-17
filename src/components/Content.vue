<template>
  <main class="content-container">
    <section class="intro-section">
      <h2>欢迎来到我的空间</h2>
      <p>这里展示我的设计作品和开发项目，涵盖UI/UX设计、前端开发和交互原型制作。</p>
    </section>
    
    <section class="about-section">
  <h3>关于我</h3>
  <p>5年经验的全栈设计师，擅长React/Vue前端开发和用户体验设计，主导过多个企业级项目的架构设计和实施。</p>
</section>

<section class="experience-section">
  <h3>项目经验</h3>
  <ul class="project-list">
    <li>电商后台管理系统（Vue3 + Element Plus）</li>
    <li>智能家居控制面板（React + TypeScript）</li>
    <li>数据可视化分析平台（Echarts + WebGL）</li>
    <li>移动端教育类小程序（Uniapp + Vuex）</li>
  </ul>
</section>
  </main>
</template>

<style scoped>
.content-container {
  padding: 2rem 1rem;
  max-width: 1200px;
  margin: 0 auto;
}

.intro-section {
  text-align: center;
  margin-bottom: 3rem;
}

.intro-section h2 {
  color: var(--primary-color);
  margin-bottom: 1rem;
}

.about-section,
.experience-section {
  background: var(--background-color);
  padding: 2rem;
  border-radius: 8px;
  margin-bottom: 2rem;
}

.project-list {
  padding-left: 1.5rem;
  line-height: 1.8;
}

.project-list li {
  margin-bottom: 0.8rem;
  position: relative;
}

.project-list li::before {
  content: '▹';
  position: absolute;
  left: -1.2rem;
  color: var(--primary-color);
}

@media (max-width: 768px) {
  .portfolio-grid {
    grid-template-columns: 1fr;
  }
  
  .item-placeholder {
    height: 200px;
  }
}
</style>