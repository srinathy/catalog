class ApplicationController < ActionController::Base
  protect_from_forgery
  add_crumb I18n.t("index_page"), '/'

  private
  def add_category_crumbs(obj)
    unless (obj.is_a? Category)
      obj = Category.find_by_id(obj)
      return if obj.nil?
    end
    
    obj.path.each {|item| add_crumb item.title, url_for(:controller => "videofiles", :action => 'index', :category => item.id) }
  end
  
end
