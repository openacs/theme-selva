# $Id$

# RAC: If dotlrn is not installed selva-master uses selva-site-master, 
# otherwise uses selva-dotlrn-master
# this should also allow for pages to call the dotlrn template (i.e. tabs) off
# maybe by passing a propery in a page

set dotlrn_installed_p [apm_package_installed_p dotlrn]

append url [ad_url] [ad_return_url]
