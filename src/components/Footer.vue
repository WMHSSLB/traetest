<template>
  <footer class="app-footer">
    <div class="footer-content">
      <div class="nav-links">
        <h4>快速导航</h4>
        <a href="#">关于我们</a>
        <a href="#">服务项目</a>
        <a href="#">客户案例</a>
        <a href="#">技术博客</a>
      </div>

      <div class="contact-info">
        <h4>联系我们</h4>
        <p>邮箱：contact@example.com</p>
        <p>电话：+86 400-123-4567</p>
        <p>地址：北京市朝阳区某某大厦</p>
      </div>

      <div class="social-section">
        <h4>关注我们</h4>
        <div class="social-links">
          <a href="#"><img src="/images/微博.svg" alt="微博"></a>
          <a href="#"><img src="/images/微信.svg" alt="微信"></a>
          <a href="https://www.douyin.com/user/self?from_tab_name=main"><img src="/images/抖音.svg" alt="抖音"></a>
        </div>
      </div>
    </div>
    <p class="copyright">© 2024 个人空间 保留所有权利</p>
  </footer>
</template>

<style scoped>
.app-footer {
  background-color: var(--primary-color);
  padding: 3rem 1rem 1rem;
  margin-top: auto;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 2rem;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

.social-links {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
}

.social-links a {
  display: block;
  width: 32px;
  height: 32px;
  transition: transform 0.2s;
}

.social-links img {
  width: 100%;
  height: 100%;

}

.social-links a:hover {
  transform: translateY(-2px);
}

.copyright {
  border-top: 1px solid rgba(255,255,255,0.3);
}

@media (max-width: 768px) {
  .footer-content {
    gap: 2rem;
    padding: 0 1rem 1.5rem;
  }
}
</style>