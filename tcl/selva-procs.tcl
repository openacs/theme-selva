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
        {-user_id:required}
        {-link_control_panel:required}
        {-control_panel_text:required}
	{-link_all 0}
        {-pre_html ""}
        {-post_html ""}
    } {
        A helper procedure that generates the PORTAL navbar (the thing
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
            
            if {[dotlrn::user_p -user_id $user_id]} {
                # this user is a dotlrn user, show their personal portal
                # navbar, including the control panel link
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

       #AG: This code belongs in the portal package, near portal::navbar.  For display reasons we need to do this
	#as a ul instead of a table, which portal::navbar returns.  Obviously we shouldn't be letting display-level
	#stuff decide where we put our code, but first we'll need to mod the portal package accordingly.

	set page_num [ns_queryget page_num]
	#Strip out extra anchors and other crud.
	#page_num will be empty_string for special pages like
	#My Space and Control Panel
	regsub -all {[^0-9]} $page_num {} page_num
	
	set navbar "<ul>\n"
	
	db_foreach list_page_nums_select {} {
	    if { ("$dotlrn_url/" == [ad_conn url] || "$dotlrn_url/index" == [ad_conn url]) && $sort_key == 0 && $page_num == ""} {
		# active tab is  first tab and page_num may be ""
		append navbar "\n<li class=\"current\"><a href=\"#\">$pretty_name</a></li>"
	     } elseif {$page_num == $sort_key} {
		 # We are looking at the active tab
		 append navbar "\n<li class=\"current\"><a href=\"#\">$pretty_name</a></li>"
	     } else {
		 append navbar "\n<li><a href=\"$link?page_num=$sort_key\">$pretty_name</a> </li>"
	     }
	 }

        #
        # Common code for the the behavior of the control panel link (class administration
        # or my account)
        #

	 if {$show_control_panel} {
	     if {$link_control_panel} {
		 append navbar "<li><a href=\"$control_panel_url\">$control_panel_text</a></li>"

	     } else {
		 append navbar "<li class=\"current\"><a href=\"#\">$control_panel_text</a></li>"
	     } 
	 }

	append navbar "</ul>"

    }

}