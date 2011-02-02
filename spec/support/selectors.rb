module MozNavSpecSelectors
  HEADER_ID = 'moz-nav-header'
  FOOTER_ID = 'moz-nav-footer'
  BODY_ID = 'moz-nav-body'

  def header_nav_user_box
    find("##{HEADER_ID} .user-links")
  end

  def header_nav_bar
    find("##{HEADER_ID} .navigation ul")
  end

  def header_sub_nav_for(li_class)
    find("##{HEADER_ID} .navigation li.#{li_class} ul")
  end

  def footer
    find("##{FOOTER_ID}")
  end

  def footer_social_links
    find("##{FOOTER_ID} .social")
  end

  def header_blue_box_page_title
    find("##{BODY_ID} .page-header h1")
  end

  def header_blue_box_page_subtitle
    find("##{BODY_ID} .page-header p")
  end

  def header_sub_nav_bar
    find("##{BODY_ID} .subnav")
  end
  
  def header_sub_sub_nav_bar
    find("##{BODY_ID} ul.sub-subnav")
  end

  def active_header_sub_nav_item
    find("##{BODY_ID} ul.subnav li.active")
  end

  def header_search_form
    find("##{HEADER_ID} form.search")
  end

  def campaign_drop_down
    find("##{BODY_ID} ul.campaigns")
  end
end
