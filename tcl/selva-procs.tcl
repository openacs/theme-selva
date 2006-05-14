#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

# tcl/portal-procs.tcl

ad_library {

    Selva.

    @author Jeremy Monnet (jmonnet@gmail.com)
    @creation-date June 2005
    @version $Id$

}

namespace eval selva {

    ad_proc -public portal_navbar {
	
    } {
	A helper procedure that generates the Navbar, ie the tabs,
	for dotlrn. It is called from the selva-master template.
    } {
	set current_url [ad_conn url]

	# Set up some basic stuff
	set community_id [dotlrn_community::get_community_id]

	# Get user information
	set sw_admin_p 0
	set user_id [ad_conn user_id]
	set untrusted_user_id [ad_conn untrusted_user_id]
	if { $untrusted_user_id != 0 } {
	    set user_name [person::name -person_id $untrusted_user_id]
	    set pvt_home_url [ad_pvt_home]
	    set pvt_home_name [_ acs-subsite.Your_Account]
	    set logout_url [ad_get_logout_url]
	    
	    # Site-wide admin link
	    set admin_url {}
	    
	    set sw_admin_p [acs_user::site_wide_admin_p -user_id $untrusted_user_id]
	    
	    if { $sw_admin_p } {
		set admin_url "/acs-admin/"
		set locale_admin_url "/acs-lang/admin"
		set dotlrn_admin_url "/dotlrn/admin"
	    } else {
		set subsite_admin_p [permission::permission_p \
					 -object_id [subsite::get_element -element object_id] \
					 -privilege admin \
					 -party_id $untrusted_user_id]
		
		if { $subsite_admin_p  } {
		    set admin_url "[subsite::get_element -element url]admin/"
		}
	    }
	} else {
	    set login_url [ad_get_login_url -return]
	    set user_name {}
	}
	
	set navbar "<ul>"

	set tabs_list [list]

	if { [exists_and_not_null community_id] } {
            set type [dotlrn_community::get_community_type_from_community_id $community_id]
            if { $type eq "dotlrn_community" || $type eq "dotlrn_club" || $type eq "dotlrn_pers_community" } {
                 set community_message_key "#dotlrn.My_Community#"
            } else {
                 set community_message_key "#dotlrn.My_Class#"
            }
	    lappend tabs_list [list "$current_url" $community_message_key]
	} 

	foreach {url name} [parameter::get_from_package_key -package_key "theme-selva" -parameter "AdditionalNavbarTabs" -default ""] {
	    lappend tabs_list [list "$url" "$name"]
	}

	if { $sw_admin_p } {
	    lappend tabs_list [list "$dotlrn_admin_url" "#dotlrn.Administration_Cockpit#"]
	}

	ns_log Debug "TABS" $tabs_list
	foreach tab_entry $tabs_list {
	    set url [lindex $tab_entry 0]
	    set name [lindex $tab_entry 1]
	    ns_log Debug "URL:: $url"
	    ns_log Debug "NAME:: $name"
	    # if url is /dotlrn or /dotlrn/index we highlight the "Home" tab, otherwise we highlight the tab with the current_url, if there is one, i.e. we are not in a community
	    if { $url == $current_url || ($url == "/dotlrn/" && $current_url == "/dotlrn/index")} {
		append navbar "\n<li class=\"active\"><a href=\"$url\">"
		#if {$picture != "null" } { append navbar "<img src=\"$picture\" alt=\"$picture\">" }
		append navbar "[lang::util::localize $name]</a></li>"
	    } else {
		append navbar "\n<li><a href=\"$url\">[lang::util::localize $name]</a></li>"
	    }
	    
	}
	
	append navbar "\n</ul>"

    }

    ad_proc -public portal_subnavbar {
        {-user_id:required}
        {-link_control_panel:required}
        {-control_panel_text:required}
	{-link_all 0}
        {-pre_html ""}
        {-post_html ""}
    } {
        A helper procedure that generates the portal subnavbar (the thing
        with the portal pages on it) for dotlrn. It is called from the
        dotlrn-master template
    } {
                
        set dotlrn_url [dotlrn::get_url]
        set community_id [dotlrn_community::get_community_id]
        set control_panel_name control-panel
	set control_panel_url "$dotlrn_url/$control_panel_name"
           
        if {[empty_string_p $community_id]} {
            # We are not under a dotlrn community. However we could be
            # under /dotlrn (i.e. in the user's portal) or anywhere
            # else on the site
            set link "[dotlrn::get_url]/"
            
            if {[dotlrn::user_p -user_id $user_id] &&
                ($link eq [ad_conn url] || "${link}index" eq [ad_conn url]) } {
                # this user is a dotlrn user, show their personal portal
                # subnavbar, including the control panel link
                set portal_id [dotlrn::get_portal_id -user_id $user_id]
                set show_control_panel 1
            } else {
                # not a dotlrn user, so no user portal to show
                set portal_id {}
                set show_control_panel 0
            }

        } else {
            #
            # We are under a dotlrn community. Get the community's portal_id, etc.
            #
            
            # some defaults
            set text [dotlrn_community::get_community_header_name $community_id] 
            set control_panel_name one-community-admin
	    # link is important : it sets the options_set value, which will be used later to select the current page
            set link [dotlrn_community::get_community_url $community_id]
	    set control_panel_url "$link/$control_panel_name"

            # figure out what this privs this user has on the community
            set admin_p [dotlrn::user_can_admin_community_p \
                -user_id $user_id \
                -community_id $community_id
            ]
        
            if {!$admin_p} {
                # the user can't admin this community, perhaps they are a
                # humble member instead?
                set member_p [dotlrn_community::member_p $community_id $user_id]
                set show_control_panel 0
            } else {
                # admins always get the control_panel_link, unless it's
                # explictly turned off
                set show_control_panel 1
            }
        
            if {$admin_p || $member_p} {
    
                set portal_id [dotlrn_community::get_portal_id \
                    -community_id $community_id
                ]
            } else {
                # show this person the comm's non-member-portal
                set portal_id [dotlrn_community::get_non_member_portal_id \
                    -community_id $community_id
                ]
            }
        }

       #AG: This code belongs in the portal package, near portal::subnavbar.  For display reasons we need to do this
	#as a ul instead of a table, which portal::subnavbar returns.  Obviously we shouldn't be letting display-level
	#stuff decide where we put our code, but first we'll need to mod the portal package accordingly.

	if { [catch {set page_num [ad_get_client_property dotlrn page_num]}] || $page_num eq "" || ![string is integer $page_num] } {
	    set page_num [ns_queryget page_num]
	    #Strip out extra anchors and other crud.
	    #page_num will be empty_string for special pages like
	    #My Space and Control Panel
	    regsub -all {[^0-9]} $page_num {} page_num
	}
	
	set subnavbar "<ul>\n"
	
	db_foreach list_page_nums_select {} {
	    if {[string equal $page_num $sort_key]} {
		append subnavbar "\n<li class=\"active\"><a href=\"$link?page_num=$sort_key\">$pretty_name</a> </li>"
	    } else {
		append subnavbar "\n<li><a href=\"$link?page_num=$sort_key\">$pretty_name</a> </li>"
	    }
	 }

	if  {[regexp {dotlrn/(clubs|classes)/*} [ad_conn url]]} { 
	    if {[string match "*/one-community-admin" [ad_conn url]]} {
		append subnavbar "\n<li class=\"active\"><a href=\"${link}one-community-admin\">Admin</a></li>"
	    } else {
		append subnavbar "\n<li><a href=\"${link}one-community-admin\">Admin</a></li>"
	    }
	}

	append subnavbar "</ul>"

    }

}
