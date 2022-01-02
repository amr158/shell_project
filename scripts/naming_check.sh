#!/bin/bash
case $* in
	+([A-Za-z0-9_]) )
		res="valid"
		;;
	*)
		echo "name can only contains small or capital letter or _"
		res="notvalid"
		;;
esac
