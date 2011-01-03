class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_page

  private
  def init_page
    add_crumb I18n.t("index_page"), '/'
    I18n.locale = params[:locale] || APP_CONFIG[:locale]
  end
  
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
  
  def add_category_crumbs(obj)
    unless (obj.is_a? Category)
      obj = Category.find_by_id(obj)
      return if obj.nil?
    end
    
    obj.path.each {|item| add_crumb item.title, url_for(:controller => "videofiles", :action => 'index', :category => item.id) }
  end
  
end
