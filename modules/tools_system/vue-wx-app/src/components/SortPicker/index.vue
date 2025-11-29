<template>
  <view v-if="show" class="sort-picker-mask" @tap="close">
    <view class="sort-picker" @tap.stop>
      <view class="picker-header">
        <view class="drag-indicator"></view>
        <text class="title">排序方式</text>
      </view>
      
      <view class="sort-options">
        <view 
          v-for="option in sortOptions"
          :key="option.value"
          class="sort-option"
          :class="{ active: current === option.value }"
          @tap="selectSort(option.value)"
        >
          <text>{{ option.label }}</text>
          <text v-if="current === option.value" class="check">✓</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
interface Props {
  show: boolean
  current: string
}

interface Emits {
  (e: 'update:show', value: boolean): void
  (e: 'update:current', value: string): void
  (e: 'change', value: string): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const sortOptions = [
  { value: 'downloads', label: '下载量' },
  { value: 'likes', label: '喜欢数' },
  { value: 'publish_time', label: '发布时间' }
]

const close = () => {
  emit('update:show', false)
}

const selectSort = (value: string) => {
  emit('update:current', value)
  emit('change', value)
  emit('update:show', false)
}
</script>

<style lang="scss" scoped>
.sort-picker-mask {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: 1000;
  display: flex;
  align-items: flex-end;
}

.sort-picker {
  width: 100%;
  background: #fff;
  border-radius: 20rpx 20rpx 0 0;
  padding: 30rpx;
  animation: slideUp 0.3s ease-out;
}

@keyframes slideUp {
  from {
    transform: translateY(100%);
  }
  to {
    transform: translateY(0);
  }
}

.picker-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 30rpx;
  
  .drag-indicator {
    width: 80rpx;
    height: 8rpx;
    background: #ddd;
    border-radius: 4rpx;
    margin-bottom: 20rpx;
  }
  
  .title {
    font-size: 32rpx;
    font-weight: bold;
    color: #333;
  }
}

.sort-options {
  .sort-option {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30rpx 20rpx;
    margin: 8rpx 0;
    border-radius: 12rpx;
    font-size: 28rpx;
    color: #333;
    
    &.active {
      background: rgba(0,122,255,0.1);
      color: #007aff;
      font-weight: bold;
    }
    
    .check {
      color: #007aff;
      font-weight: bold;
      font-size: 32rpx;
    }
  }
}
</style>