class LinksController < ApplicationController

require 'nokogiri'
require 'open-uri'
require "pismo"
require 'net/http'

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
    @url = params.fetch(:url,'')
    if @url != ''
      if create_link(@url)
        redirect_to LinksHelper.fix_url(@url)
      end
    else
      @link=current_user.links.build
      #@link = Link.new
      respond_with(@link)
    end
  end

  def edit
  end

  def create
    @url=params.fetch(:link).fetch(:url)
    if create_link(@url)
      redirect_to @link, notice: 'Link was saved'
    else
      render action: 'new'
    end
  end

  def create_link(url)
    url=LinksHelper.fix_url(url)
    #res=Net::HTTP.get_response(URI(url))
    #url=res['location']
    doc = Pismo::Document.new(url)
    doc2 = Nokogiri::HTML(open(url))
    content=doc2.to_html

    @link = current_user.links.build(title: doc.title, url: url,html:content)
    @link.save
  end

  def save
    @url=params.fetch(:url)
    redirect_to @url
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
