<master src="/packages/theme-selva/www/selva-master">


<blockquote>
<h1>Selva for designers</h1>
Selva simplifies the work of customizing the look and feel of your OpenACS/dotLRN website.

<h1>Templates</h1>
<h2>Not yet using Selva?</h2>
<ol>
<li>Go to the <a href="/acs-admin/apm">Package manager page</a></li> 
<li>Click in 'install packages'</li>
<li>The system will check for all uninstalled packages in your local directory. Choose theme-selva.</li>
<li>Restart the server</li></li>
 </ol>

The following documentation will be useful.
<ul>
<li><a href="templates.html">How old templates worked</a></li>
<li><a href="sample.html">A sample page</a></li>
<li><a href="/doc/acs-templating">Templating system documentation</a></li>
<li><a href="howto/">Theme Howto</a></li>
</ul>


<h1>How to modify Selva templates</h1>
<h2>Modifying selva's theme</h2>
You can create a new theme by copying /packages/new-portal/www/themes/selva-theme.adp to /packages/new-portal/www/themes/yourtheme.adp
and the directory (that conpatins the theme's images) sloan-theme to yourtheme-theme. 
<br/ >
This changes the inside of the portlet.
<br/ >
(still do not know how to get it listed in /dotlrn/admin/templates)



changed main-navigation for portal navigation class in    /packages/dotlrn/tcl/navigation-procs.tcl


<h2>Modifying SelvaFlex theme</h2>
New themes should be added in the www/resources directory. 
Each directory should contain all images and a single selva.css file.

<h1>Selva presentation and Quality Assurance</h1>
In order to improve and maintain the quality of the themes in Selva we would like all 
'certified' themes to be Accesible W3C Level A compliant and XHTML compliant.

<h2>Making your page accessible</h2>
A comple accessibility analysis was performed on the portal template used in dotlrn 2.1.1.
You should read "<a href="http://dotlrn.org/conferences/Madrid05/">Towards an Accessible Learning Management System</a> for a full description.


<h2>Making your page XHTML compliant</h2>
Check out the same document above.

<h1>Credits</h1>

A number of people has collaborated with these themes:
<ul>
<li>Art Director + graphic design + CSS: Dorian Peters</li>
<li>Default Selva theme impelmentation: Jeremy Monet</li>
<li>Selva Flex implementation: Inigo Medina Garcia</li>
<li>Documentation and coordination: Rafael Calvo</li>
</ul>




</blockquote>
