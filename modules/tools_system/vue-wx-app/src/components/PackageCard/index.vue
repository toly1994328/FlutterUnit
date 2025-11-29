<template>
  <view class="package-card" @tap="$emit('tap')">
    <view class="header">
      <view class="name">{{ package.name }}</view>
      <view class="version">v{{ package.version }}</view>
    </view>
    
    <view class="description">{{ package.description }}</view>
    
    <view class="stats">
      <view class="stat-item">
        <text class="icon">📥</text>
        <text>{{ formatNumber(package.downloads) }}</text>
      </view>
      <view class="stat-item">
        <text class="icon">❤️</text>
        <text>{{ formatNumber(package.likes) }}</text>
      </view>
      <view class="stat-item">
        <text class="icon">📅</text>
        <text>{{ formatDate(package.publishTime) }}</text>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import type { Package } from '@/api'

defineProps<{
  package: Package
}>()

defineEmits<{
  tap: []
}>()

const formatNumber = (num: number) => {
  if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`
  if (num >= 1000) return `${(num / 1000).toFixed(1)}K`
  return num.toString()
}

const formatDate = (dateStr: string) => {
  const date = new Date(dateStr)
  const now = new Date()
  const diff = now.getTime() - date.getTime()
  
  const days = Math.floor(diff / (1000 * 60 * 60 * 24))
  if (days === 0) return '今天'
  if (days === 1) return '昨天'
  if (days < 30) return `${days}天前`
  
  return date.toLocaleDateString()
}
</script>

<style lang="scss" scoped>
.package-card {
  background: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 10rpx rgba(0,0,0,0.1);
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
  
  .name {
    font-size: 32rpx;
    font-weight: bold;
    color: #333;
  }
  
  .version {
    font-size: 24rpx;
    color: #007aff;
    background: #f0f8ff;
    padding: 8rpx 16rpx;
    border-radius: 20rpx;
  }
}

.description {
  font-size: 28rpx;
  color: #666;
  line-height: 1.5;
  margin-bottom: 20rpx;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
}

.stats {
  display: flex;
  gap: 40rpx;
  
  .stat-item {
    display: flex;
    align-items: center;
    gap: 8rpx;
    font-size: 24rpx;
    color: #666;
    
    .icon {
      font-size: 28rpx;
    }
  }
}
</style>