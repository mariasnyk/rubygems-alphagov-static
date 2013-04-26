Static::Application.routes.draw do
  match "/templates/campaign.html.erb", :to => "root#campaign"
  match "/templates/wrapper.html.erb", :to => "root#wrapper"
  match "/templates/wrapper_with_js_last.html.erb", :to => "root#wrapper_with_js_last"
  match "/templates/print.html.erb", :to => "root#print"
  match "/templates/related.raw.html.erb", :to => "root#related"
  match "/templates/report_a_problem.raw.html.erb", :to => "root#report_a_problem"
  match "/templates/homepage.html.erb", :to => "root#homepage"
  match "/templates/admin.html.erb", :to => "root#admin"
  match "/templates/404.html.erb", :to => "root#404"
  match "/templates/406.html.erb", :to => "root#406"
  match "/templates/410.html.erb", :to => "root#410"
  match "/templates/418.html.erb", :to => "root#418"
  match "/templates/500.html.erb", :to => "root#500"
  match "/templates/501.html.erb", :to => "root#501"
  match "/templates/503.html.erb", :to => "root#503"
  match "/templates/504.html.erb", :to => "root#504"
  match "/templates/header_footer_only.html.erb", :to => "root#header_footer_only"
  match "/templates/chromeless.html.erb", :to => "root#chromeless"
  match "/templates/beta_notice.html.erb", :to => "root#beta_notice"
  match "/templates/proposition_menu.html.erb", :to => "root#proposition_menu"

  match "/templates/barclays_epdq.html", :to => "root#barclays_epdq"

  match "/apple-touch-icon.png", :to => "apple_icons#show"
  match "/apple-touch-icon-144x144.png", :to => "apple_icons#show"
  match "/apple-touch-icon-114x114.png", :to => "apple_icons#show"
  match "/apple-touch-icon-72x72.png", :to => "apple_icons#show"
  match "/apple-touch-icon-57x57.png", :to => "apple_icons#show"
  match "/apple-touch-icon-precomposed.png", :to => "apple_icons#show"

  match "/static/overseas-passport/OS_Payment_Instruction.pdf",
    :to => redirect("#{Plek.current.website_root}/government/publications/overseas-passport-creditdebit-card-payment-authorisation")
end
