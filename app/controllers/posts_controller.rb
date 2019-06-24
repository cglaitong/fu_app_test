require 'httparty'
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  require "uri"
  require 'json'
  require "net/http"
  include HTTParty

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    #render json: @post
    aux =""
    tam = @post.uploads.length
    limit = tam -1
    for j in 0..limit

      if j < limit
        aux = aux+ @post.uploads_on_disk(j) + ","
      elsif j == limit
        aux = aux+ @post.uploads_on_disk(j)

      end
    end
    #puts  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

    render json: output = {'path' => "#{aux}"}.to_json
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    aux =""
    aux2 =""
    if @post.save


      tam = @post.uploads.length
      limit = tam -1
      for j in 0..limit

        if j < limit
          aux = aux+ @post.uploads_on_disk(j) + ","
         aux2 = aux2 + @post.uploads[j].filename.to_s + ","
        elsif j == limit
        #CAMBIO PERMANENTE  aux2 = aux2 + @post.uploads[j].filename.to_s
          aux = aux+ @post.uploads_on_disk(j)
          aux2 = aux2 + @post.uploads[j].filename.to_s

        end
      end
      #puts  "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      #puts aux

      #render json: output = {'path' => "#{aux}"}.to_json

      pruebaJ= @post.to_json
      pruebaH=JSON.parse(pruebaJ)

      #puts "sdsdsadsadasdsadsadsadsadasdsadsad"
      #puts pruebaJ
      #puts pruebaH
      pruebaH.delete("created_at")
      pruebaH.delete("updated_at")
      #hash2 = {'path' => "#{aux}"}
      #puts hash2
      pruebaH.store("path",aux)
     # varuser= "usuatio1"
      #pruebaH.store("user",varuser)
      pruebaH.store("name",aux2)

      #puts pruebaH
      #pruebaJ.push({"path" => aux})


      #render json: pruebaJ
      params = {"path" => "valor"}
query = { 
  "path"     => "neworder",
  "n"      => 1404996028,
  "order_type" => "buy",
  "quantity"   => 1,
  "rate"       => 1
}
      #x = Net::HTTP.post_form URI('http://192.168.99.101:2870/upload?'), params
      #puts x.body
	@result = HTTParty.post("http://file-controller-ms:2870/upload",
		:query => pruebaH,
	    	:headers => { 'Content-Type' => 'application/json' } )
      render json: pruebaH.to_json
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.permit(:name, :owner, :description, uploads: [])
  end


end
