extends AudioStreamPlayer2D

@onready var playback: AudioStreamPlaybackInteractive = get_stream_playback()

# Store the last known clip index to track changes
var last_clip_index: int = -1

func _process(_delta: float) -> void:
	if playback:
		var current_clip_index: int = playback.get_current_clip_index()
		if current_clip_index != last_clip_index:
			last_clip_index = current_clip_index
			
			if stream is AudioStreamInteractive:
				var lab: Label = get_node("../Label")
				var clip_name: String = stream.get_clip_name(current_clip_index)
				lab.text = 'music clip ' +str(current_clip_index)+ ' '+ clip_name
