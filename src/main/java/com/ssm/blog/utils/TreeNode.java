package com.ssm.blog.utils;

import com.ssm.blog.entity.Comment;

import java.util.ArrayList;
import java.util.List;

public class TreeNode {
    public TreeNode(){}

    /*
    * 初始化收集comment树的容器
    *
    * */
    private List<Comment> commentList = new ArrayList<Comment>();

    /*
    * 把List的comment集合转换成comment树
    * */
    public List toTreeNode(List<Comment> comments){

        this.commentList = iteration(commentList,comments);

        return commentList;
    }

    /*
    * 迭代函数
    * */
    public List iteration(List<Comment> commentList,List<Comment> comments){
        //当comment容器为空时，先收集根节点
        if (commentList.size() == 0){
            //收集根节点
            for (int i = 0; i < comments.size(); i++) {
                if (comments.get(i).getPid() == 0){
                    commentList.add(comments.get(i));
                }
            }

            //以根节点为基础，循环找出每个根节点的子节点
            for (int i = 0; i < commentList.size(); i++) {
                for (int j = 0; j < comments.size(); j++) {
                    if (commentList.get(i).getId() == comments.get(j).getPid()){
                        //当comment容器某节点的id等于某comment的pid时，把该comment设置为该节点的子节点
                        commentList.get(i).setChildrenComment(comments.get(j));
                    }
                }
                //当comment容器某节点有子节点时，以子节点为基础迭代添加孙节点
                if (commentList.get(i).getChildrenComment().size() > 0){
                    iteration(commentList.get(i).getChildrenComment(),comments);
                }
            }
        }else {//当comment容器不为空时，走该分支，情况与上面一模一样
            for (int i = 0; i < commentList.size(); i++) {
                for (int j = 0; j < comments.size(); j++) {
                    if (commentList.get(i).getId() == comments.get(j).getPid()){
                        commentList.get(i).setChildrenComment(comments.get(j));
                    }
                }
                if (commentList.get(i).getChildrenComment().size() > 0){
                    iteration(commentList.get(i).getChildrenComment(),comments);
                }
            }
        }
        //返回comment树容器
        return commentList;
    }

}
