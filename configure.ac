AC_INIT(e-tizen-data, 0.1, gl77.lee@samsung.com)
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR(configure.ac)

AC_PREFIX_DEFAULT($prefix)

PKG_CHECK_MODULES(EET, [eet])
AC_ARG_WITH(eet-eet,
[   --with-eet-eet=PATH             specify a specific path to eet utility],
[
   v=$withval;
   eet_eet=$v
   echo "   Enlightenment eet explicitly set to "$eet_eet;
],[
   eet_eet=$(pkg-config --variable=prefix eet)/bin/eet
])
AC_SUBST(eet_eet)

PKG_CHECK_MODULES(EDJE, [edje])
AC_ARG_WITH(edje-cc,
  AC_HELP_STRING([--with-edje-cc=PATH], [specify a specific path to edje_cc]),
  [
    v=$withval;
    EDJE_CC=$v
  ],[
    EDJE_CC=$(pkg-config --variable=prefix edje)/bin/edje_cc
  ]
)
AC_SUBST(EDJE_CC)

enabled_modules='group "modules" list {
   group "E_Config_Module" struct {
     value "name" string: "wl_drm";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 0;
   }
   group "E_Config_Module" struct {
     value "name" string: "wl_desktop_shell";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 0;
   }
   group "E_Config_Module" struct {
     value "name" string: "e-mod-tizen-wm-policy";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 0;
   }
   group "E_Config_Module" struct {
     value "name" string: "e-mod-tizen-keyrouter";
     value "enabled" uchar: 0;
     value "delayed" uchar: 0;
     value "priority" int: 0;
   }
   group "E_Config_Module" struct {
     value "name" string: "bufferqueue";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 0;
   }
   group "E_Config_Module" struct {
     value "name" string: "e-mod-tizen-processmgr";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 0;
   }
   group "E_Config_Module" struct {
     value "name" string: "e-mod-tizen-devicemgr";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 0;
   }
   group "E_Config_Module" struct {
     value "name" string: "e-mod-tizen-wl-textinput";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 0;
   }
   group "E_Config_Module" struct {
     value "name" string: "e-mod-tizen-gesture";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 20;
   }
   group "E_Config_Module" struct {
     value "name" string: "e-mod-tizen-screen-reader";
     value "enabled" uchar: 1;
     value "delayed" uchar: 0;
     value "priority" int: 20;
   }
 }'
AC_SUBST([enabled_modules])
AM_SUBST_NOTMAKE([enabled_modules])
### Done MODULES

### composite engine
AC_ARG_WITH(engine,
            AC_HELP_STRING([--with-engine=sw|gl], [composite engine to be used]),
            [if test "x$withval" = "xgl"; then
               COMP_ENGINE=2
             elif test "x$withval" = "xsw"; then
               COMP_ENGINE=1
             else
               COMP_ENGINE=0
             fi
            ],
            [COMP_ENGINE=0])
AC_SUBST([COMP_ENGINE])
### Done COMP_ENGINE

### skip first damage
AC_ARG_ENABLE([skip-first-damage],
              AC_HELP_STRING([--disable-skip-first-damage], [disable skip first damage]),
              [SKIP_FIRST_DAMAGE=${enableval}], [SKIP_FIRST_DAMAGE=1])
AC_SUBST([SKIP_FIRST_DAMAGE])
AM_SUBST_NOTMAKE([SKIP_FIRST_DAMAGE])
### Done SKIP_FIRST_DAMAGE

AC_CONFIG_FILES([
default/config/tizen-common/e.src
default/config/tizen-common/e_comp.src
default/config/tizen-common/e_bindings.src
Makefile
default/Makefile
default/backgrounds/Makefile
default/config/Makefile
default/config/tizen-common/Makefile
default/themes/Makefile
])
AC_OUTPUT([
])

