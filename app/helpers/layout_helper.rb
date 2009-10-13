module LayoutHelper
  
  def title(page_title, body_id = nil)
    @page_title = page_title.to_s
    @body_id = body_id
  end

end