<master src="/packages/theme-selva/www/selva-site-master">
  <property name="header_stuff">
    @header_stuff;noquote@
  </property>
  <if @context@ not nil><property name="context">@context;noquote@</property></if>
    <else><if @context_bar@ not nil><property name="context_bar">@context_bar;noquote@</property></if></else>
  <if @focus@ not nil><property name="focus">@focus;noquote@</property></if>
  <if @doc_type@ not nil><property name="doc_type">@doc_type;noquote@</property></if>
 

<if @youarehere@ not nil><div id="youarehere">@youarehere;noquote@</div><br /></if> 

<div id="portal-navigation">
<if @navbar@ not nil>@navbar;noquote@</if> 
</div> <!-- end of  portal-navigation-->

<div id="portal-subnavigation">
	<div id="portal-subnavigation-links">
	<if @subnavbar@ not nil>@subnavbar;noquote@</if> 	
	</div>
	
</div>

<div id="portal">
  

  <slave>
  <div style="clear: both;"></div>
</div>

<div id="portal-bottom"></div>

<div id="footer">
  <a href="http://www.dotlrn.org">.LRN Home</a> |
  <a href="http://www.openacs.org/projects/dotlrn">.LRN Project Central</a>
</div>
