module PagesHelper

  def campfire_link
    link_to_if(current_user, 'Houston.rb campfire chat room',
               'http://zipzoomauto.campfirenow.com/1c8f5') do |name|
      link_to(name, login_path)
    end
  end

end
