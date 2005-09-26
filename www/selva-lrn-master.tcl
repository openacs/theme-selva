# $Id$

#append url [ad_url] [ad_return_url]
set user_id [ad_get_user_id] 
set community_id [dotlrn_community::get_community_id]
set dotlrn_url [dotlrn::get_url]

# most of this is not used and shouild be removed
#Scope Related graphics/css parameters
# Set everything for user level scope as default then modify it later as we refine the scope.
set scope_name "user"
set scope_main_color "#003366"
set scope_header_color "#6DB2C9"
set scope_highlight_text "white"
set scope_z_dark "#C9D7DC"
set scope_z_light "#EAF0F2"
set scope_light_border "#DDEBF5"
set help_url "[dotlrn::get_url]/control-panel"
set header_font "Arial, Helvetica, sans-serif"
set header_font_size "medium"
set header_font_color "black"
set header_logo_item_id ""
set header_img_url "/resources/dotlrn/logo" 
set header_img_file "[acs_root_dir]/packages/dotlrn/www/resources/logo"
set header_img_alt_text "Header Logo"

set extra_spaces "<img src=\"/resources/dotlrn/spacer.gif\" alt=\"\" border=0 width=15>"
set td_align "align=\"center\" valign=\"top\""

if {[dotlrn::user_p -user_id $user_id]} {
    set portal_id [dotlrn::get_portal_id -user_id $user_id]
}

if {![empty_string_p $community_id]} {
    set have_comm_id_p 1
} else {
    set have_comm_id_p 0
}

if {[exists_and_not_null portal_id]} {
    set have_portal_id_p 1
} else {
    set have_portal_id_p 0 
}

# navbar vars
set show_navbar_p 1
if {[exists_and_not_null no_navbar_p] && $no_navbar_p} {
    set show_navbar_p 0
} 

if {![info exists link_all]} {
    set link_all 0
}

if {![info exists return_url]} {
    set link [ad_conn -get extra_url]
} else {
    set link $return_url
}

if {![info exists link_control_panel]} {
    set link_control_panel 1
}

if { ![string equal [ad_conn package_key] [dotlrn::package_key]] } {
    # Peter M: We are in a package (an application) that may or may not be under a dotlrn instance 
    # (i.e. in a news instance of a class)
    # and we want all links in the navbar to be active so the user can return easily to the class homepage
    # or to the My Space page
    set link_all 1
}

if {$have_comm_id_p} {
    # in a community or just under one in a mounted package like /calendar 
    # get this comm's info
    set control_panel_text "Administer"

    set portal_id [dotlrn_community::get_portal_id -community_id $community_id]
    set text [dotlrn_community::get_community_header_name $community_id] 
    set link [dotlrn_community::get_community_url $community_id]
    set admin_p [dotlrn::user_can_admin_community_p -user_id $user_id -community_id $community_id]

    if {[empty_string_p $portal_id] && !$admin_p } {
        # not a member yet
        set portal_id [dotlrn_community::get_non_member_portal_id -community_id $community_id]
    }

    if { $have_portal_id_p && $show_navbar_p } {
	set make_navbar_p 1

    } else {
	set make_navbar_p 0
        set portal_id ""
    }
} elseif {[parameter::get -parameter community_type_level_p] == 1} {
    set control_panel_text "Administer"

    set extra_td_html ""
    set link_all 1
    set link [dotlrn::get_url]
    # in a community type
    set text \
            [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
    
    if {$have_portal_id_p && $show_navbar_p} {
	set make_navbar_p 1
    } else {
	set make_navbar_p 0
        set portal_id ""
    }
} else {
    # we could be anywhere (maybe under /dotlrn, maybe not)
    set control_panel_text "My Account"
    set link "[dotlrn::get_url]/"
    set community_id ""
    set text ""
    set make_navbar_p 1
    if {$have_portal_id_p && $show_navbar_p} {
    } else {
	set make_navbar_p 0
	set portal_id ""
    }
}

# Set up some basic stuff
set user_id [ad_get_user_id]
if { [ad_conn untrusted_user_id] == 0 } {
    set user_name {}
} else {
    set user_name [acs_user::get_element -user_id [ad_conn untrusted_user_id] -element name]
}

if {![exists_and_not_null title]} {
    set title [ad_system_name]
}

if {[empty_string_p [dotlrn_community::get_parent_community_id -package_id [ad_conn package_id]]]} {
    set parent_comm_p 0
} else {
    set parent_comm_p 1
}

set community_id [dotlrn_community::get_community_id]

set control_panel_text [_ "dotlrn.control_panel"]

if {![empty_string_p $community_id]} {
    # in a community or just under one in a mounted package like /calendar 
    set comm_type [dotlrn_community::get_community_type_from_community_id $community_id]
    set control_panel_text [_ acs-subsite.Admin]

    if {[dotlrn_community::subcommunity_p -community_id $community_id]} {
	#The colors for a subgroup are set by the parent group with a few overwritten.
	set comm_type [dotlrn_community::get_community_type_from_community_id [dotlrn_community::get_parent_id -community_id $community_id]]
    }

    if {$comm_type == "dotlrn_club"} {
	    #community colors
	    set scope_name "comm"
	    set scope_main_color "#CC6633"
	    set scope_header_color "#F48F5C"
	    set scope_z_dark "#FFDDB0"
	    set scope_z_light "#FFF2E2"
	    set scope_light_border "#E7B59C"
	if {[dotlrn_community::subcommunity_p -community_id $community_id]} {
	    set scope_z_dark "#FFDDB0"
	    set scope_z_light "#FFF2E2"
	}
    } else {
	set scope_name "course"
	set scope_main_color "#6C9A83"
	set scope_header_color $scope_main_color
	set scope_z_dark "#CDDED5"
	set scope_z_light "#E6EEEA"
	set scope_light_border "#D0DFD9"
	if {[dotlrn_community::subcommunity_p -community_id $community_id]} {
	    set scope_z_dark "#D0DFD9"
	    set scope_z_light "#ECF3F0"
	}
    }
  
    # DRB: default logo for dotlrn is a JPEG provided by Collaboraid.  This can
    # be replaced by custom gifs if prefered (as is done by SloanSpace)

    if { [file exists "$header_img_file-$scope_name.jpg"] } {
        set header_img_url "$header_img_url-$scope_name.jpg"
    } elseif { [file exists "$header_img_file-$scope_name.gif"] } {
        set header_img_url "$header_img_url-$scope_name.gif"
    }
  
   # set header_img_url "$header_img_url-$scope_name.gif"

   # font hack
   set community_header_font [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_font
    ]

    if {![empty_string_p $community_header_font]} {
	set header_font "$community_header_font,$header_font"
    }


    set header_font_size [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_font_size
    ]

    set header_font_color [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_font_color
    ]

    # logo hack 
    set header_logo_item_id [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_logo_item_id
    ]

    if {![empty_string_p $header_logo_item_id]} {

	# Need filename
        set header_img_url "[dotlrn_community::get_community_url $community_id]/file-storage/download/?version_id=$header_logo_item_id" 
    }
	
   
    set header_logo_alt_text [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_logo_alt_text
    ]

    if {![empty_string_p $header_logo_alt_text]} {
        set header_img_alt_text $header_logo_alt_text
    } 

    set text [dotlrn::user_context_bar -community_id $community_id]

    if { [string equal [ad_conn package_key] [dotlrn::package_key]] } {
        set text "<span class=\"header-text\">$text</span>"
    }

} elseif {[parameter::get -parameter community_type_level_p] == 1} {
    # in a community type (subject)
    set text \
            [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
} else {
    # under /dotlrn

    # DRB: default logo for dotlrn is a JPEG provided by Collaboraid.  This can
    # be replaced by custom gifs if prefered (as is done by SloanSpace)

    if { [file exists "$header_img_file-$scope_name.jpg"] } {
        set header_img_url "$header_img_url-$scope_name.jpg"
    } elseif { [file exists "$header_img_file-$scope_name.gif"] } {
        set header_img_url "$header_img_url-$scope_name.gif"
    }

    set text ""
}

if { $make_navbar_p } {
	set link_control_panel 0
  
    
    if {[exists_and_not_null community_id]} {
	set youarehere "[dotlrn_community::get_community_name $community_id]"
    } else {
	set youarehere "[_ theme-selva.MySpace]"
    }

    set extra_spaces "<img src=\"/resources/dotlrn/spacer.gif\" alt=\"\" border=0 width=15>"    
    #set subnavbar [selva::portal_navbar]
    set subnavbar [selva::portal_subnavbar \
        -user_id $user_id \
        -link_control_panel $link_control_panel \
        -control_panel_text $control_panel_text \
	-pre_html "$extra_spaces" \
	-post_html $extra_spaces \
        -link_all $link_all
    ]

    
    set navbar [selva::portal_navbar]
    
} else {
    set navbar " "
    set subnavbar " "
}


if { ![info exists header_stuff] } {
    set header_stuff ""
}

if { [info exists text] } {
    set text [lang::util::localize $text]
}


# Focus
multirow create attribute key value

if { ![template::util::is_nil focus] } {
    # Handle elements wohse name contains a dot
    if { [regexp {^([^.]*)\.(.*)$} $focus match form_name element_name] } {

        # Add safety code to test that the element exists '
        set header_stuff "$header_stuff
          <script language=\"JavaScript\" type=\"text/javascript\">
            function acs_focus( form_name, element_name ){
                if (document.forms == null) return;
                if (document.forms\[form_name\] == null) return;
                if (document.forms\[form_name\].elements\[element_name\] == null) return;
                if (document.forms\[form_name\].elements\[element_name\].type == 'hidden') return;

                document.forms\[form_name\].elements\[element_name\].focus();
            }
          </script>
        "
        
        template::multirow append \
                attribute onload "javascript:acs_focus('${form_name}', '${element_name}')"
    }
}

# Developer-support support
set ds_enabled_p [parameter::get_from_package_key \
    -package_key acs-developer-support \
    -parameter EnabledOnStartupP \
    -default 0
]

if {$ds_enabled_p} {
    set ds_link [ds_link]
} else {
    set ds_link {}
}

set change_locale_url "/acs-lang/?[export_vars { { package_id "[ad_conn package_id]" } }]"

# Hack for title and context bar outside of dotlrn

set in_dotlrn_p [expr [string match "[dotlrn::get_url]/*" [ad_conn url]]]

if { [info exists context] } {
    set context_bar [eval ad_context_bar $context]
}

set acs_lang_url [apm_package_url_from_key "acs-lang"]
set lang_admin_p [permission::permission_p \
                      -object_id [site_node::get_element -url $acs_lang_url -element object_id] \
                      -privilege admin \
                      -party_id [ad_conn untrusted_user_id]]
set toggle_translator_mode_url [export_vars -base "${acs_lang_url}admin/translator-mode-toggle" { { return_url [ad_return_url] } }]

# Curriculum bar
set curriculum_bar_p [llength [site_node::get_children -all -filters { package_key "curriculum" } -node_id $community_id]]
