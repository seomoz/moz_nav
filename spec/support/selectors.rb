module MozNavSpecSelectors
  HEADER_ID = 'moz-nav-header'

  def header_nav_user_box_items
    all("##{HEADER_ID} .userbox li")
  end
end
