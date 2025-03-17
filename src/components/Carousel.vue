<template>
  <div class="carousel-container" @mouseover="pauseAutoPlay" @mouseleave="resumeAutoPlay">
    <div class="carousel-track" :style="trackStyle">
      <img 
        v-for="(img, index) in images"
        :key="index"
        class="carousel-item"
        :class="{ 'first-three': index < 3 }"
        :src="img"
        :alt="'Slide ' + index"
      />
    </div>
    
    <div class="carousel-dots">
      <button
        v-for="(dot, index) in images"
        :key="index"
        :class="{ active: currentIndex === index }"
        @click="goToSlide(index)"
      ></button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue';

const images = [
  '/images/1_0f1eff125e24f48ade461806353e03df.jpg',
  '/images/1_231e173afd9a0f25df100b18e4bd2024.jpg',
  '/images/1_698952a3bbdd19521351124cdf4e5eef.jpg',
  '/images/1_9d084a61be4d20f67d827afec903ef0d.jpg',
  '/images/3a7ee5e44fc447b3c5230309445d7943.jpg'
];

const currentIndex = ref(0);
const autoPlay = ref(true);
let intervalId = null;

const trackStyle = computed(() => ({
  transform: `translateX(-${currentIndex.value * 100}%)`,
  transition: 'transform 0.5s ease-in-out'
}));

const startAutoPlay = () => {
  if (autoPlay.value) {
    intervalId = setInterval(() => {
      currentIndex.value = (currentIndex.value + 1) % images.length;
    }, 5000);
  }
};

const pauseAutoPlay = () => {
  autoPlay.value = false;
  clearInterval(intervalId);
};

const resumeAutoPlay = () => {
  autoPlay.value = true;
  startAutoPlay();
};

const goToSlide = (index) => {
  currentIndex.value = index;
};

onMounted(startAutoPlay);
onBeforeUnmount(() => {
  clearInterval(intervalId);
});
</script>

<style scoped>
.carousel-container {
  position: relative;
  overflow: hidden;
  height: 50vh;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  box-sizing: border-box;
}

.carousel-item {
  flex: 0 0 100%;
  width: 100%;
  max-width: 100%;
  height: 100%;
  object-fit: contain;
  max-height: 80vh;
  object-position: center top;
}

@media (max-width: 768px) {
  .carousel-container {
    height: 40vh;
    max-width: 100%;
  }
}

.carousel-track {
  display: flex;
  height: 100%;
  width: 100%;
  flex-shrink: 0;
}

.carousel-dots {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 10px;
}

.carousel-dots button {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: none;
  background: rgba(255,255,255,0.5);
  cursor: pointer;
  transition: all 0.3s;
}

.carousel-dots .active {
  background: var(--primary-color);
  transform: scale(1.2);
}
</style>