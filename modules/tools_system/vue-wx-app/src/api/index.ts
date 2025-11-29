interface ApiResponse<T> {
  success: boolean
  data: T
  msg: string
  total?: number
}

interface Category {
  id: number
  key: string
  name: string
  description: string
}

interface Package {
  id: number
  name: string
  version: string
  description: string
  downloads: number
  likes: number
  publishTime: string
  homepage?: string
  repository?: string
}

interface Comment {
  id: number
  packageId: number
  parentId?: number
  userId?: number
  guestName: string
  content: string
  contentType: string
  rating?: number
  createAt: string
  replies: Comment[]
  repliesTotal: number
}

class ApiClient {
  private baseURL = 'http://localhost:8080'

  private async request<T>(
    url: string,
    options: UniApp.RequestOptions = {}
  ): Promise<ApiResponse<T>> {
    return new Promise((resolve, reject) => {
      uni.request({
        url: `${this.baseURL}${url}`,
        method: options.method || 'GET',
        data: options.data,
        header: {
          'Content-Type': 'application/json',
          ...options.header
        },
        success: (res) => {
          resolve(res.data as ApiResponse<T>)
        },
        fail: (error) => {
          console.error('API请求失败:', error)
          reject(error)
        }
      })
    })
  }

  // 获取分类
  async getCategories(): Promise<ApiResponse<Category[]>> {
    return this.request<Category[]>('/categories')
  }

  // 获取插件列表
  async getCategoryPackages(
    categoryKey: string,
    params: {
      page?: number
      pageSize?: number
      sortBy?: string
    } = {}
  ): Promise<ApiResponse<Package[]>> {
    return this.request<Package[]>(`/categories/${categoryKey}/export`, {
      data: {
        page: params.page || 1,
        page_size: params.pageSize || 10,
        sort_by: params.sortBy || 'downloads'
      }
    })
  }

  // 获取插件详情
  async getPackageDetail(packageId: number): Promise<ApiResponse<Package>> {
    return this.request<Package>(`/packages/${packageId}`)
  }

  // 获取评论
  async getPackageComments(
    packageId: number,
    params: { page?: number; pageSize?: number } = {}
  ): Promise<ApiResponse<Comment[]>> {
    return this.request<Comment[]>(`/packages/${packageId}/comments`, {
      data: {
        page: params.page || 1,
        page_size: params.pageSize || 10
      }
    })
  }

  // 发送评论
  async sendComment(
    packageId: number,
    content: string,
    guestName: string,
    parentId?: number
  ): Promise<ApiResponse<Comment>> {
    return this.request<Comment>(`/packages/${packageId}/comments`, {
      method: 'POST',
      data: {
        content,
        guest_name: guestName,
        parent_id: parentId
      }
    })
  }

  // 提交反馈
  async submitFeedback(
    feedbackType: string,
    title: string,
    content: string
  ): Promise<ApiResponse<any>> {
    return this.request('/feedback', {
      method: 'POST',
      data: {
        feedback_type: feedbackType,
        title,
        content
      }
    })
  }
}

export const api = new ApiClient()
export type { Category, Package, Comment, ApiResponse }