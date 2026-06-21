export_local:
	(cd game; ~/own/tool/Godot_v4.6.3-stable_linux.x86_64 --export-release Web ../export/flycatcher.html )
	cp export/* /my/post/flycatcher/

.PHONY: export_local

export_zip:
	rm -f export/*
	(cd game; ~/own/tool/Godot_v4.6.3-stable_linux.x86_64 --export-release Web ../export/index.html )
	zip export/flycatcher.zip export/*
	echo "export/flycatcher.zip 1152x648"