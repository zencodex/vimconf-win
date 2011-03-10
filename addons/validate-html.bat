:: sudo ln -s `pwd`/validate-html.sh /usr/bin/validate-html.sh
:: Many thanks to Anselm Garbe for helping me with the blasted sed regexp

@echo off
::curl -s -F laxtype=yes -F parser=html5 -F level=error -F out=gnu -F doc=@%1 "http://validator.nu" | sed 's,^.*":,'"%1:"','
curl -s -F laxtype=yes -F parser=html5 -F level=error -F out=gnu -F doc=@%1 "http://validator.nu" | sed "s,^.*"":,""%1:"","
