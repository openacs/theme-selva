# $Id$

# RAC: If dotlrn is not installed selva-master uses selva-site-master, 
# otherwise uses selva-dotlrn-master
# this should also allow for pages to call the dotlrn template (i.e. tabs) off
# maybe by passing a propery in a page

if {![exists_and_not_null displayed_object_id]} {
    set displayed_object_id ""
}

if {[exists_and_not_null title]} {
    set doc(title) $title
}

if {![exists_and_not_null context]} {
    set context ""
}

set dotlrn_installed_p [apm_package_installed_p dotlrn]

append url [ad_url] [ad_return_url]
