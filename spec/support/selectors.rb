module MozNavSpecSelectors
  HEADER_ID = 'moz-nav-header'

  def header_nav_user_box_items
    all("##{HEADER_ID} .user-box li")
  end

  def header_nav_bar_items
    all("##{HEADER_ID} .nav-bar li")
  end
end
