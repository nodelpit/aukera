module ApplicationHelper
  def home_page?
    current_page?(root_path)
  end

  def show_nav_element?
    !home_page?
  end
end
