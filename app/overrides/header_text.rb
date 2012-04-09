Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
                     :name => "pages_in_footer",
                     :insert_bottom => "#top-nav-bar",
                     :partial => "shared/header_text")