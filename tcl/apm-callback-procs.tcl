ad_library {

     Theme Selva Package APM callbacks library

     Procedures that deal with installing.

     @creation-date May 2006
     @author  Don Baccus (dhogaza@pacifier.com)
     @cvs-id $Id$

}

namespace eval theme_selva {}
namespace eval theme_selva::apm {}

ad_proc -public theme_selva::apm::after_upgrade {
    {-from_version_name:required}
    {-to_version_name:required}
} {
    apm_upgrade_logic \
        -from_version_name $from_version_name \
        -to_version_name $to_version_name \
	-spec {  
	    0.7d5 2.2.0b1 {     
                apm_parameter_register \
                    AdditionalNavbarTabs \
                    "list of URL Names pairs which will make it into additional navbar tabs" \
                    theme-selva \
                    "/dotlrn/ #dotlrn.Home# /theme-selva/courses #dotlrn.Courses# /theme-selva/communities #dotlrn.Communities# /dotlrn/control-panel #dotlrn.control_panel#" \
                    string 
	}
	    2.2.0b1 2.2.0b2 {     
                apm_parameter_register \
                    subgroupCssUrl \
                    "default subgroup css_url" \
                    theme-selva \
                    "/resources/theme-selva/Selva/brown/Selva.css" \
                    string 
	}
    }
}
