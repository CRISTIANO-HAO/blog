import request from '@/utils/request'

export function getArticleList(data) {
  return request({
    url:"/admin/article/page",
    method: "post",
    params: data
  })
}
