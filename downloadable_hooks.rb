class DownloadableHooks < Spree::ThemeSupport::HookListener

  # Downloadables tab to admin area
  insert_after :admin_product_tabs, :partial => "admin/shared/downloadables_tab"

end
