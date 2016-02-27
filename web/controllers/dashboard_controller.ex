defmodule FromSpace.DashboardController do
  use FromSpace.Web, :controller
  alias FromSpace.Post
  
  plug FromSpace.Plug.Auth

  def dashboard(conn, _params) do
    posts = Repo.all(Post)
    render conn, "index.html", conn: conn, posts: posts
  end

  def editor(conn, %{"post_id" => post_id}) do
    post = Repo.get_by(Post, id: post_id)
    changeset = Post.changeset(post)
    render conn, FromSpace.PostView, "edit.html", changeset: changeset, post: post, conn: conn
  end

  def editor(conn, _params) do
    changeset = changeset = Post.changeset(%Post{})
    render conn, FromSpace.PostView, "new.html", changeset: changeset, conn: conn
  end

  def preview(conn, %{"post_id" => post_id}) do
    post = Repo.get_by(Post, id: post_id)
    changeset = Post.changeset(post)
    render conn, FromSpace.PostView, "preview.html", post: post
  end
end