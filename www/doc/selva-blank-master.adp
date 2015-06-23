@doc_type;noquote@
<html>
  <head>
    <meta name="generator" content="OpenACS version @openacs_version@">
    <title>@title;noquote@</title>
    <multiple name="header_links">
      <link rel="@header_links.rel@" type="@header_links.type@" href="@header_links.href@" media="@header_links.media@">
    </multiple>

    <if @acs_blank_master__htmlareas@ not nil>
      <script type="text/javascript" src="/resources/acs-templating/htmlarea/htmlarea.js"></script>
      <script type="text/javascript" src="/resources/acs-templating/htmlarea/lang/en.js"></script>
      <script type="text/javascript" src="/resources/acs-templating/htmlarea/dialog.js"></script>

      <style type="text/css">
      @import url(/resources/acs-templating/htmlarea/htmlarea.css);
      </style>
    </if>

    <script src="/resources/acs-subsite/core.js" language="javascript"></script>

    @header_stuff;noquote@
  </head>
  <body<multiple name="attribute"> @attribute.key@="@attribute.value@"</multiple>>


<!-- Toolbars for developers -->
    <textarea id="holdtext" style="display: none;" rows="1" cols="1"></textarea>
    <if @dotlrn_toolbar_p@ true>
      <include src="/packages/dotlrn/lib/toolbar">
    </if>
    <if @developer_support_p@ true>
      <include src="/packages/acs-developer-support/lib/toolbar">
    </if>


<div id="wrapper"><!-- old page-body --> 
  
<!-- header (contains logo) -->
<div id="header">
	<if @title@ not nil>
		<a href="/" alt="@title;noquote@">
	<img src="/Selva/images/logo.gif" alt="@title;noquote@" border="0"></a>
</div>

    <h1 class="page-title">@title;noquote@</h1>
  </if>
  <else>
  <div id="header">
	<a href="/">
	<img src="/Selva/images/logo.gif" border="0"></a>
	</div></else>
  

<!-- Breadcrumbs and status (contains name, members online,logout)-->
<div id="breadcrumbs">
You are here > .LRN > MySpace

	<div id="status">
	Dorian Peters | 	
	<a href="">2 members online</a> | 
	<a href="">log out</a>
	</div>

</div>

    <slave>

    <if @developer_support_p@ true>
      <include src="/packages/acs-developer-support/lib/footer">
    </if>
    <if @translator_mode_p@ true>
      <include src="/packages/acs-lang/lib/messages-to-translate">
    </if>
  </body>

</html>
