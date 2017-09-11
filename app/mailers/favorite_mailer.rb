class FavoriteMailer < ApplicationMailer

  default from: "kimberlyvnguyen@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@http://localhost:3000/>"
    headers["In-Reply-To"] = "<post/#{post.id}@http://localhost:3000/>"
    headers["References"] = "<post/#{post.id}@http://localhost:3000/"
    @user = user
    @post = post
    @comment = comment
    mail(to: user.email, subject: "New comment on #{post.title}")
  end

end
