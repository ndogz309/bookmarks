class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @links = Link.all
    respond_with(@links)
  end

  # def show
  #   respond_with(@link)
  # end

  def show
    @link = Link.find(params.fetch(:id))
    #@content= Pismo::Document.new(@link.url).body
  #  @content= Pismo::Document.new(@link.url).body
doc = Nokogiri::HTML(open(@link.url))
#doc = Nokogiri::HTML(open('http://www.nokogiri.org/tutorials/installing_nokogiri.html'))

    end

@content=doc
  end




  def new
@link=current_user.links.build

    #@link = Link.new
    respond_with(@link)
  end

  def edit
  end


  def create
    UrlParser.generate_link(params.fetch(:link).fetch(:url))
    flash[:notice] = "Link was successfully created"
    redirect_to links_path
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
      params.require(:link).permit(:url,:title)
    end
end
