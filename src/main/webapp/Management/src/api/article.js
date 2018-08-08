import request from '@/utils/request'

export function getArticleList(data) {
  return request({
    url:"/admin/article/page",
    method: "post",
    params: data
  })
}

export function getArticleAsset() {
  return request({
    url:"/admin/article/asset",
    method: "get"
  })
}

export function titleIfExist(data) {
  return request({
    url:"/admin/article/title/ifexist",
    method: "post",
    params:data
  })
}

export function addArticle(data) {
  return request({
    url:"/admin/article/add",
    method: "post",
    data:data
  })
}

export function updateArticle(data) {
  return request({
    url:"/admin/article/update",
    method: "post",
    data:data
  })
}

export function getArticleById(data) {
  return request({
    url:"/admin/article/get",
    method: "get",
    params:data
  })
}

export function deleteArticleById(data) {
  return request({
    url:"/admin/article/delete",
    method: "get",
    params:data
  })
}
