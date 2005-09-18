<%

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

%>

<master>
<property name="title">@title@</property>
<property name="link_control_panel">0</property>



<div id="left-column">
<div class="portlet-wrapper">
<div class="portlet-title"><span>@portlet_title@</span>
</div> <!-- class : portlet-title -->
<div class="portlet">
  <include src="/packages/dotlrn/www/dotlrn-main-portlet" show_buttons_p="1" show_archived_p=0 title="Groups" referer="@dotlrn_url@/control-panel">
 </div> <!-- class : portlet -->
 </div> <!-- classs : portlet-wrapper -->
</div> <!-- id : left-column -->