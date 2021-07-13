eix-sync && emerge -uDN @world && emerge @preserved-rebuild && emerge --depclean && revdep-rebuild && perl-cleaner --all && python-updater && haskell-updated && eclean-pkg && eclean-dist
