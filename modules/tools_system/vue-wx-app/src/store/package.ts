import { defineStore } from 'pinia'
import { api, type Package } from '@/api'

interface PackageState {
  packagesByCategory: Record<string, Package[]>
  loading: Record<string, boolean>
  hasMore: Record<string, boolean>
  currentPackage: Package | null
}

export const usePackageStore = defineStore('package', {
  state: (): PackageState => ({
    packagesByCategory: {},
    loading: {},
    hasMore: {},
    currentPackage: null
  }),

  getters: {
    getPackagesByCategory: (state) => (categoryKey: string) => {
      return state.packagesByCategory[categoryKey] || []
    },

    isLoading: (state) => (categoryKey: string) => {
      return state.loading[categoryKey] || false
    },

    hasMoreData: (state) => (categoryKey: string) => {
      return state.hasMore[categoryKey] !== false
    }
  },

  actions: {
    async loadPackages(params: {
      categoryKey: string
      sortBy?: string
      isRefresh?: boolean
    }) {
      const { categoryKey, sortBy = 'downloads', isRefresh = false } = params

      this.loading[categoryKey] = true

      try {
        const result = await api.getCategoryPackages(categoryKey, {
          page: 1,
          pageSize: 20,
          sortBy
        })

        if (result.success) {
          this.packagesByCategory[categoryKey] = result.data
          this.hasMore[categoryKey] = result.data.length === 20
        } else {
          uni.showToast({
            title: result.msg,
            icon: 'error'
          })
        }
      } catch (error) {
        uni.showToast({
          title: '加载失败',
          icon: 'error'
        })
      } finally {
        this.loading[categoryKey] = false
      }
    },

    async loadMore(categoryKey: string) {
      if (!this.hasMore[categoryKey] || this.loading[categoryKey]) return

      const currentPackages = this.packagesByCategory[categoryKey] || []
      const page = Math.floor(currentPackages.length / 20) + 1

      this.loading[categoryKey] = true

      try {
        const result = await api.getCategoryPackages(categoryKey, {
          page,
          pageSize: 20
        })

        if (result.success) {
          this.packagesByCategory[categoryKey] = [
            ...currentPackages,
            ...result.data
          ]
          this.hasMore[categoryKey] = result.data.length === 20
        }
      } catch (error) {
        uni.showToast({
          title: '加载失败',
          icon: 'error'
        })
      } finally {
        this.loading[categoryKey] = false
      }
    },

    async loadPackageDetail(packageId: number) {
      try {
        const result = await api.getPackageDetail(packageId)
        if (result.success) {
          this.currentPackage = result.data
        } else {
          uni.showToast({
            title: result.msg,
            icon: 'error'
          })
        }
      } catch (error) {
        uni.showToast({
          title: '加载详情失败',
          icon: 'error'
        })
      }
    }
  }
})