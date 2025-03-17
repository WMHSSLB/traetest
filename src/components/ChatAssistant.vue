<template>
  <div class="chat-assistant">
    <button 
      class="trigger-button"
      @click="toggleChat"
    >
      <span class="icon">💬</span>
    </button>

    <div v-if="isOpen" class="chat-container">
      <div class="chat-header">
        <h3>智能助手</h3>
        <button class="close-btn" @click="toggleChat">×</button>
      </div>
      
      <div class="messages-container">
        <div 
          v-for="(msg, index) in messages"
          :key="index"
          class="message"
          :class="{ 'user-msg': msg.isUser }"
        >
          {{ msg.content }}
        </div>
      </div>

      <div class="input-area">
        <input
          v-model="inputMessage"
          @keyup.enter="sendMessage"
          placeholder="输入消息..."
        />
        <button @click="sendMessage">发送</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const isOpen = ref(false);
const inputMessage = ref('');
const messages = ref([
  { content: '您好！我是您的智能助手，有什么可以帮您？', isUser: false }
]);

const toggleChat = () => {
  isOpen.value = !isOpen.value;
};

const sendMessage = async () => {
  if (!inputMessage.value.trim()) return;
  
  const userMessage = inputMessage.value;
  messages.value.push({ content: userMessage, isUser: true });
  inputMessage.value = '';
  
  try {
    // 添加API密钥检测
if (!import.meta.env.VITE_DEEPSEEK_API_KEY) {
  messages.value.push({ content: '错误：请先配置API密钥', isUser: false });
  return;
}

const response = await fetch('https://api.siliconflow.cn/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${import.meta.env.VITE_DEEPSEEK_API_KEY}`,
        'API-Header': 'Silicon-Flow'
      },
      body: JSON.stringify({
        model: 'Qwen/QwQ-32B',
        messages: [{ role: 'user', content: userMessage }],
        temperature: 0.7,
        top_p: 0.7,
        top_k: 50,
        frequency_penalty: 0.5,
        max_tokens: 1000,
        n: 1,
        stream: true
      })
    });

    const reader = response.body.getReader();
    const decoder = new TextDecoder();
    let assistantResponse = '';
    
    const newMsg = { content: '', isUser: false };
    messages.value.push(newMsg);
    const msgIndex = messages.value.length - 1;
    
    try {
      while (true) {
        const { done, value } = await reader.read();
        if (done) break;
        
        const chunk = decoder.decode(value, { stream: true });
const buffer = [];
let partialChunk = '';

const processChunk = (chunk) => {
  const lines = (partialChunk + chunk).split('\n');
  partialChunk = lines.pop() || '';

  for (const line of lines) {
    if (line.startsWith('data: ')) {
      buffer.push(line.replace('data: ', '').trim());
    }
  }
};

const processBuffer = () => {
  while (buffer.length) {
    const message = buffer.shift();
    if (message === '[DONE]') continue;

    try {
      const parsed = JSON.parse(message);
      // 适配API返回格式
      if (parsed.choices?.[0]?.delta?.content) {
        const newMessages = [...messages.value];
        newMessages[msgIndex].content += parsed.choices[0].delta.content;
        messages.value = newMessages;
      } else if (parsed.choices?.[0]?.message?.content) {
        // 处理非流式响应
        const newMessages = [...messages.value];
        newMessages[msgIndex].content = parsed.choices[0].message.content;
        messages.value = newMessages;
      }
    } catch (parseError) {
      console.error('解析数据块失败:', parseError.message, '原始数据:', message);
    }
  }
};

processChunk(chunk);
processBuffer();
      }
    } catch (streamError) {
      console.error('流式数据解析失败:', streamError);
      messages.value.push({ 
        content: '数据接收异常，请重试', 
        isUser: false 
      });
    } finally {
      reader.releaseLock();
    }
  } catch (error) {
    console.error('API请求失败:', error);
    // 添加网络错误提示
    let errorMessage = error.message || '网络连接异常';
    if (error.message.includes('Failed to fetch')) {
      errorMessage = '网络请求失败，请检查网络连接';
    }
    // 详细错误日志
    if (error.response) {
      errorMessage = `状态码: ${error.response.status} ${error.response.statusText}`;
      console.error('响应头:', error.response.headers);
      const responseBody = await error.response.text();
      console.error('API响应内容:', responseBody);
      
      if (error.response.status === 401) {
        errorMessage += ' (API密钥无效)';
      } else if (error.response.status >= 500) {
        errorMessage += ' (服务器内部错误)';
      }
    } else if (error.request) {
      errorMessage = '网络请求未收到响应';
      console.error('请求配置:', error.config);
      console.error('请求头:', error.config.headers);
    }
    
    messages.value.push({ 
      content: `请求失败：${errorMessage}（详细日志请查看控制台）`, 
      isUser: false 
    });
    console.error('完整请求配置:', {
      url: 'https://api.siliconflow.cn/v1/chat/completions',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${import.meta.env.VITE_DEEPSEEK_API_KEY?.substring(0, 5)}...`
      },
      body: JSON.stringify({ model: 'siliconflow-chat', messages: [{ role: 'user', content: userMessage }], stream: true })
    });
  }
};
</script>

<style scoped>
.chat-assistant {
  position: fixed;
  right: 30px;
  bottom: 30px;
  z-index: 1000;
}

.trigger-button {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background-color: var(--primary-color);
  border: none;
  box-shadow: 0 4px 12px rgba(0,0,0,0.2);
  cursor: pointer;
  transition: transform 0.2s;
}

.trigger-button:hover {
  transform: scale(1.1);
}

.icon {
  font-size: 24px;
}

.chat-container {
  width: 350px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 8px 24px rgba(0,0,0,0.15);
  overflow: hidden;
}

.chat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: var(--primary-color);
  color: var(--text-light);
}

.close-btn {
  background: none;
  border: none;
  color: inherit;
  font-size: 24px;
  cursor: pointer;
}

.messages-container {
  height: 400px;
  min-height: 300px;
  padding: 1rem;
  overflow-y: auto;
  background: #f8f9fa;
  display: flex;
  flex-direction: column;
  gap: 0.8rem;
}

.message {
  margin: 0;
  padding: 0.8rem;
  border-radius: 12px;
  background: white;
  max-width: 80%;
  word-break: break-word;
}

.user-msg {
  margin-left: auto;
  background: var(--primary-color);
  color: var(--text-light);
  align-self: flex-end;
}

.input-area {
  display: flex;
  padding: 1rem;
  gap: 0.5rem;
  border-top: 1px solid #eee;
}

input {
  flex: 1;
  padding: 0.8rem;
  border: 1px solid #ddd;
  border-radius: 8px;
}

button {
  padding: 0.8rem 1.2rem;
  background-color: var(--primary-color);
  color: var(--text-light);
  border: none;
  border-radius: 8px;
  cursor: pointer;
}
</style>