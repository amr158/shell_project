#!/bin/bash
case "$1" in
	*\ * )
		echo space not allowed
		res="notvalid"
		;;
	* )
		case "$1" in
			[a-z]*)
				res="valid"
				;;
			[A-Z]*)
				res="valid"
				;;
			_*)
				res="valid"
				;;
			*)
				res="notvalid"
				echo "name can only start with small or capital letter or _"
				;;
		esac

		;;
esac
