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
}
