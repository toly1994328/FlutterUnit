<template>
  <view class="container">
    <!-- 顶部导航 -->
    <view class="header">
      <view class="title">Flutter插件库</view>
      <view class="actions">
        <view class="action-btn" @tap="navigateToRecommend">
          <text class="icon">📤</text>
        </view>
        <view class="action-btn" @tap="showSortPicker">
          <text class="icon">🔽</text>
        </view>
      </view>
    </view>

    <!-- 分类标签 -->
    <scroll-view scroll-x class="tabs" v-if="categories.length > 0">
      <view class="tab-list">
        <view 
          v-for="category in categories" 
          :key="category.key"
          class="tab-item"
          :class="{ active: currentCategory === category.key }"
          @tap="onTabChange(category.key)"
        >
          {{ category.name }}
        </view>
      </view>
    </scroll-view>

    <!-- 插件列表 -->
    <scroll-view 
      scroll-y 
      class="package-list"
      @scrolltolower="onLoadMore"
      refresher-enabled
      :refresher-triggered="refreshing"
      @refresherrefresh="onRefresh"
    >
      <PackageCard 
        v-for="pkg in packages" 
        :key="pkg.id"
        :package="pkg"
        @tap="navigateToDetail(pkg)"
      />
      
      <view v-if="loading" class="loading">
        <text>加载中...</text>
      </view>

      <view v-if="packages.length === 0 && !loading" class="empty">
        <text>暂无数据</text>
      </view>
    </scroll-view>

    <!-- 排序选择器 -->
    <SortPicker 
      v-model:show="showSort"
      v-model:current="currentSort"
      @change="onSortChange"
    />
  </view>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { usePackageStore } from '@/store/package'
import { useCategoryStore } from '@/store/category'
import PackageCard from '@/components/PackageCard/index.vue'
import SortPicker from '@/components/SortPicker/index.vue'

// 状态管理
const packageStore = usePackageStore()
const categoryStore = useCategoryStore()

// 响应式数据
const currentCategory = ref('')
const currentSort = ref('downloads')
const showSort = ref(false)
const refreshing = ref(false)

// 计算属性
const categories = computed(() => categoryStore.categories)
const packages = computed(() => packageStore.getPackagesByCategory(currentCategory.value))
const loading = computed(() => packageStore.isLoading(currentCategory.value))

// 生命周期
onMounted(async () => {
  await categoryStore.loadCategories()
  if (categories.value.length > 0) {
    currentCategory.value = categories.value[0].key
    await loadPackages()
  }
})

// 方法
const onTabChange = async (categoryKey: string) => {
  if (currentCategory.value === categoryKey) return
  currentCategory.value = categoryKey
  await loadPackages()
}

const loadPackages = async () => {
  await packageStore.loadPackages({
    categoryKey: currentCategory.value,
    sortBy: currentSort.value
  })
}

const onLoadMore = async () => {
  await packageStore.loadMore(currentCategory.value)
}

const onRefresh = async () => {
  refreshing.value = true
  await loadPackages()
  refreshing.value = false
}

const showSortPicker = () => {
  showSort.value = true
}

const onSortChange = async (sortType: string) => {
  currentSort.value = sortType
  await loadPackages()
}

const navigateToDetail = (pkg: any) => {
  uni.navigateTo({
    url: `/pages/detail/index?id=${pkg.id}&name=${encodeURIComponent(pkg.name)}`
  })
}

const navigateToRecommend = () => {
  uni.navigateTo({
    url: '/pages/recommend/index'
  })
}
</script>

<style lang="scss" scoped>
.container {
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20rpx 30rpx;
  background: #fff;
  border-bottom: 1rpx solid #eee;
  
  .title {
    font-size: 36rpx;
    font-weight: bold;
    color: #333;
  }
  
  .actions {
    display: flex;
    gap: 20rpx;
  }
  
  .action-btn {
    width: 60rpx;
    height: 60rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12rpx;
    background: #f5f5f5;
    
    .icon {
      font-size: 32rpx;
    }
  }
}

.tabs {
  background: #fff;
  border-bottom: 1rpx solid #eee;
  
  .tab-list {
    display: flex;
    padding: 0 30rpx;
  }
  
  .tab-item {
    padding: 20rpx 30rpx;
    font-size: 28rpx;
    color: #666;
    white-space: nowrap;
    
    &.active {
      color: #007aff;
      border-bottom: 4rpx solid #007aff;
    }
  }
}

.package-list {
  flex: 1;
  padding: 20rpx;
}

.loading {
  display: flex;
  justify-content: center;
  padding: 40rpx;
  color: #999;
}

.empty {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 400rpx;
  color: #999;
  font-size: 28rpx;
}
</style>