module MozNavSpecSelectors
  HEADER_ID = 'moz-nav-header'

  def header_nav_user_box
    find("##{HEADER_ID} .user-box")
  end

  def header_nav_bar
    find("##{HEADER_ID} .nav-bar")
  end
end
