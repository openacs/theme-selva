
<!-- Credits 	Software development:  the .LRN development community (www.dotlrn.org)	Release Management: 	Visual Design:  Dorian Petersend Credits --><master src="/www/Selva/selva-site-master">
  <property name="header_stuff">
    <link rel="stylesheet" type="text/css" href="/Selva/Selva.css" media="all">
    <link rel="stylesheet" type="text/css" href="/resources/calendar/calendar.css" media="all">
    @header_stuff;noquote@
   </property>
  <if @context@ not nil><property name="context">@context;noquote@</property></if>
    <else><if @context_bar@ not nil><property name="context_bar">@context_bar;noquote@</property></if></else>
  <if @focus@ not nil><property name="focus">@focus;noquote@</property></if>
  <if @doc_type@ not nil><property name="doc_type">@doc_type;noquote@</property></if>
  <if @title@ not nil><property name="title">@title;noquote@</property></if>
  
  <if @navbar@ not nil>@navbar;noquote@</if>
  <div style="clear: both;"></div>

  <div id="main-container">


 
  <div style="clear: both;"></div>
  </div><!-- main-container -->

</div><!-- page-body -->

<body><!--portal (main container with portlets and navigation) --><!-- navigation tabs are produced by  /dotlrn/tcl/navigation-procs.tcl -->
<!-- Sub navigation --><div id="portal-subnavigation">	<div id="portal-subnavigation-links">	<ul> 	<li><img src="/www/Selva/images/subnavIcon_files.gif">resources</li>	<li><img src="/www/Selva/images/subnavIcon_calendar.gif">calendar</li> 	<li><img src="/www/Selva/images/subnavIcon_news.gif">news</li>	</ul> 	</div></div><!-- Main portal container (contains all portlets) --><div id="portal">  <!-- Left column of portlets-->  <div id="left-column">    		   </div>  <!-- end left column -->    <!-- Right column of portlets-->  <div id="right-column">      </div>  <!-- end right column-->
<slave>
</div><!--end portal--><div id="portal-bottom"></div>




<div id="footer">accessibility |  standards (xhtml, css, scorm, wrsl, etc.) | www.dotlrn.org</div></div><!-- end wrapper --></body></html>