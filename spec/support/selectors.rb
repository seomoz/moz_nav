module MozNavSpecSelectors
  HEADER_ID = 'moz-nav-header'
  FOOTER_ID = 'moz-nav-footer'

  def header_nav_user_box
    find("##{HEADER_ID} .user-links")
  end

  def header_nav_bar
    find("##{HEADER_ID} .user-controls")
  end

  def header_sub_nav_for(li_class)
    find("##{HEADER_ID} .user-controls li.#{li_class} .sub-nav")
  end

  def footer
    find("##{FOOTER_ID}")
  end

  def footer_social_links
    find("##{FOOTER_ID} .social-links")
  end

  def header_blue_box_page_title
    find("##{HEADER_ID} .blue-header h1")
  end

  def header_blue_box_page_subtitle
    find("##{HEADER_ID} .blue-header p")
  end

  def header_user_greeting
    find("##{HEADER_ID} .campaign-nav")
  end

  def header_search_form
    find("##{HEADER_ID} form.search")
  end
end
