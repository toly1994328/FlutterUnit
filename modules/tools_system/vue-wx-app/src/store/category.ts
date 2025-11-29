import { defineStore } from 'pinia'
import { api, type Category } from '@/api'

interface CategoryState {
  categories: Category[]
  loading: boolean
  error: string | null
}

export const useCategoryStore = defineStore('category', {
  state: (): CategoryState => ({
    categories: [],
    loading: false,
    error: null
  }),

  getters: {
    getCategoryByKey: (state) => (key: string) => {
      return state.categories.find(cat => cat.key === key)
    }
  },

  actions: {
    async loadCategories() {
      if (this.categories.length > 0) return

      this.loading = true
      this.error = null

      try {
        const result = await api.getCategories()
        if (result.success) {
          this.categories = result.data
        } else {
          this.error = result.msg
          uni.showToast({
            title: result.msg,
            icon: 'error'
          })
        }
      } catch (error) {
        this.error = '加载分类失败'
        uni.showToast({
          title: '加载分类失败',
          icon: 'error'
        })
      } finally {
        this.loading = false
      }
    }
  }
})