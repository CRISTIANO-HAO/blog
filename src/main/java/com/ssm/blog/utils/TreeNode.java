package com.ssm.blog.utils;

import com.ssm.blog.entity.Comment;

import java.util.ArrayList;
import java.util.List;

public class TreeNode {
    public TreeNode(){}

    private List<Comment> commentList = new ArrayList<Comment>();

    public List<Comment> getCommentList() {
        return commentList;
    }

    public void setCommentList(List<Comment> commentList) {
        this.commentList = commentList;
    }

    public TreeNode(List<Comment> comments){
        this.commentList = comments;
    }

    public List toTreeNode(List<Comment> comments){

        this.commentList = iteration(commentList,comments);

        return commentList;
    }

    public List iteration(List<Comment> commentList,List<Comment> comments){
        if (commentList.size() == 0){
            for (int i = 0; i < comments.size(); i++) {
                if (comments.get(i).getPid() == 0){
                    commentList.add(comments.get(i));
                }
            }

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
        }else {
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

        return commentList;
    }

}
