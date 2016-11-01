class LinksController < ApplicationController

require 'nokogiri'
require 'open-uri'
require "pismo"

  before_action :set_link, only: [:show, :edit, :update, :destroy]
 before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index

    @user = current_user

if @user != nil
    @links = @user.links
end

    respond_with(@links)
  end



  def show
    @link = Link.find(params.fetch(:id))

    # @doc = Pismo::Document.new(@link.url, :reader => :cluster)


  end




  def new
@link=current_user.links.build

    #@link = Link.new
    respond_with(@link)
  end

  def edit
  end


def create

@url=params.fetch(:link).fetch(:url)
doc = Pismo::Document.new(@url)


doc2 = Nokogiri::HTML(open(@url))
@content=doc2.to_html

  @link = current_user.links.build(title: doc.title, url: @url,html:@content)
    if @link.save
      redirect_to @link, notice: 'Question was successfully created.'
    else
      render action: 'new'
    end




  end



  # def create
  #   @link = current_user.links.build(link_params)
  #   if @link.save
  #     redirect_to @link, notice: 'Link was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  def update
    @link.update(link_params)
    respond_with(@link)
  end

  def destroy
    @link.destroy
    respond_with(@link)
  end

  private

def correct_user
      @link = current_user.links.find_by(id: params[:id])
      redirect_to links_path, notice: "Not authorized to edit this link" if @link.nil?
    end

    def set_link
      @link = Link.find(params[:id])
    end

    def link_params
      params.require(:link).permit(:url,:title,:html)
    end
end
