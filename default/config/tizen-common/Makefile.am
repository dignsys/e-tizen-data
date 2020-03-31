MAINTAINERCLEANFILES = Makefile.in

EET_EET = @eet_eet@

EXTRA_DIST = \
             module.gesture.src \
             module.devicemgr.src \
             module.screen_reader.accessibility.src \
             module.keyrouter.src \
             module.policy-tizen.src \
             e_bindings.src \
             e_comp.src \
             e.src

filesdir = $(prefix)/data/config/tizen-common/
files_DATA = \
             module.gesture.cfg \
             module.devicemgr.cfg \
             module.screen_reader.accessibility.cfg \
             module.keyrouter.cfg \
             module.policy-tizen.cfg \
             e_bindings.cfg \
             e_comp.cfg \
             e.cfg

SUFFIXES = .cfg

.src.cfg:
	$(EET_EET) -e \
	$(top_builddir)/default/config/tizen-common/$@ config \
	$< 1

clean-local:
	rm -rf *.cfg *~
