<template>
  <view class="container">
    <form @submit="onSubmit">
      <!-- 推荐说明 -->
      <view class="info-card">
        <view class="info-header">
          <text class="icon">💡</text>
          <text class="title">推荐说明</text>
        </view>
        <text class="info-content">
          推荐后，经过审核采纳，该包将收录到 FlutterUnit 插件库中，供更多开发者发现和使用。
        </text>
      </view>

      <!-- 包名称 -->
      <view class="form-group">
        <text class="label">包名称</text>
        <input 
          v-model="formData.packageName"
          class="input"
          placeholder="请输入包名称，如：dio"
          :class="{ error: errors.packageName }"
        />
        <text v-if="errors.packageName" class="error-text">{{ errors.packageName }}</text>
      </view>

      <!-- 包特点 -->
      <view class="form-group">
        <text class="label">包的特点</text>
        <textarea 
          v-model="formData.description"
          class="textarea"
          placeholder="请描述这个包的主要功能和特点，为什么推荐它..."
          :class="{ error: errors.description }"
        />
        <text v-if="errors.description" class="error-text">{{ errors.description }}</text>
      </view>

      <!-- 提交按钮 -->
      <button 
        class="submit-btn"
        :class="{ loading: submitting }"
        :disabled="submitting"
        form-type="submit"
      >
        {{ submitting ? '提交中...' : '提交推荐' }}
      </button>
    </form>
  </view>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { api } from '@/api'

// 表单数据
const formData = reactive({
  packageName: '',
  description: ''
})

// 错误信息
const errors = reactive({
  packageName: '',
  description: ''
})

// 提交状态
const submitting = ref(false)

// 表单验证
const validateForm = () => {
  errors.packageName = ''
  errors.description = ''
  
  let isValid = true
  
  if (!formData.packageName.trim()) {
    errors.packageName = '请输入包名称'
    isValid = false
  }
  
  if (!formData.description.trim()) {
    errors.description = '请描述包的特点'
    isValid = false
  } else if (formData.description.trim().length < 10) {
    errors.description = '请至少输入10个字符的描述'
    isValid = false
  }
  
  return isValid
}

// 提交表单
const onSubmit = async () => {
  if (!validateForm()) return
  
  submitting.value = true
  
  try {
    const result = await api.submitFeedback(
      'package',
      formData.packageName.trim(),
      formData.description.trim()
    )
    
    if (result.success) {
      uni.showToast({
        title: '推荐已提交，感谢您的贡献！',
        icon: 'success',
        duration: 2000
      })
      
      // 清空表单
      formData.packageName = ''
      formData.description = ''
    } else {
      uni.showToast({
        title: `提交失败：${result.msg}`,
        icon: 'error'
      })
    }
  } catch (error) {
    uni.showToast({
      title: '提交失败：网络错误',
      icon: 'error'
    })
  } finally {
    submitting.value = false
  }
}
</script>

<style lang="scss" scoped>
.container {
  padding: 30rpx;
  background: #f8f8f8;
  min-height: 100vh;
}

.info-card {
  background: #e3f2fd;
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 40rpx;
  border: 2rpx solid #bbdefb;
  
  .info-header {
    display: flex;
    align-items: center;
    margin-bottom: 20rpx;
    
    .icon {
      font-size: 32rpx;
      margin-right: 12rpx;
    }
    
    .title {
      font-size: 28rpx;
      font-weight: bold;
      color: #1976d2;
    }
  }
  
  .info-content {
    font-size: 26rpx;
    color: #1976d2;
    line-height: 1.5;
  }
}

.form-group {
  margin-bottom: 40rpx;
  
  .label {
    display: block;
    font-size: 28rpx;
    font-weight: 600;
    color: #333;
    margin-bottom: 16rpx;
  }
  
  .input, .textarea {
    width: 100%;
    padding: 24rpx;
    border: 2rpx solid #e0e0e0;
    border-radius: 12rpx;
    font-size: 28rpx;
    background: #fff;
    box-sizing: border-box;
    
    &.error {
      border-color: #f44336;
    }
    
    &:focus {
      border-color: #007aff;
    }
  }
  
  .textarea {
    min-height: 200rpx;
    resize: none;
  }
  
  .error-text {
    display: block;
    color: #f44336;
    font-size: 24rpx;
    margin-top: 12rpx;
  }
}

.submit-btn {
  width: 100%;
  height: 88rpx;
  background: #007aff;
  color: #fff;
  border: none;
  border-radius: 12rpx;
  font-size: 32rpx;
  font-weight: 600;
  
  &.loading {
    background: #ccc;
  }
  
  &:disabled {
    background: #ccc;
  }
}
</style>