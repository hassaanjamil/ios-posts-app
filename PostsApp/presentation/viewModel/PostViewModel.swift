//
//  PostViewModel.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

class PostViewModel {
    func present(post: SPost?) -> SPostViewModel {
        return SPostViewModel(postId: post?.id)
    }
}
