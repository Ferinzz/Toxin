#+ignore
package GDWrapper

import "base:runtime"
import GDE "../../gdAPI/gdextension"
import "../../gdAPI"
import sics "base:intrinsics"
import "core:slice"
import "core:reflect"
import "core:fmt"

AudioStream:: ^Object

/**************************************/
/*****AudioStreamPlaybackPlyphonic*****/
/**************************************/

/*
* AudioStreamPlaybackPlyphonic will allow you to play multiple audioStreams from a single player.
* It has an adjustable max amount of streams. Default is 32, you can adjust with set_polyphony.
* The return value is a unique integer ID that is associated to this playback stream and which can be used to control it.
* This ID becomes invalid when the stream ends (if it does not loop), when the AudioStreamPlaybackPolyphonic is stopped, or when stop_stream() is called.
* You cannot retrieve the stream ID after you setup the playback. SAVE THE VALUE OF THE STREAM ID IF YOU WANT TO MANAGE THE PLAYBACK!
*/

INVALID_ID:Int: -1

AudioStreamPlaybackPolyphonic_play_stream_default :: proc(player: ^Object, stream: ^AudioStream, r_ret: ^Int) {
    from_offset:float= 0
    volume_db:float= 0
    pitch_scale:float= 1
    playback_type: PlaybackType= .PLAYBACK_TYPE_DEFAULT
    AudioStreamPlaybackPolyphonic_play_stream(player, stream, &from_offset, &volume_db, &pitch_scale, &playback_type, GDClass_StringName_get(.Master), r_ret)
}

/*
* stream: pointer to an audio stream aka AudioStreamWAV or AudioStreamMP3
* from_offset: time in seconds from beginning
* volume_db: volume to play the stream at in Decibles
* playback_type: enum specifying how the stream should be played. typically default or stream unless you're specifically sampling portions of an audio file.
* bus: the audio bus to use. Default should be "master" These can be good to organize audio settings such as volume of dialogue vs sound effect or adding additional Effects to audio aka reverb.
* r_ret: return unique integer ID that is associated to this playback stream
*/
AudioStreamPlaybackPolyphonic_play_stream :: proc(player: ^Object, stream: ^AudioStream, from_offset: ^float,
    volume_db: ^float, pitch_scale: ^float, playback_type: ^PlaybackType, bus: ^StringName, r_ret: ^Int) {
    @(static)AudioStreamPlayerPlyphonicplaystream: GDE.MethodBindPtr
    if AudioStreamPlayerPlyphonicplaystream == nil {
        AudioStreamPlayerPlyphonicplaystream = classDBGetMethodBind3(.AudioStreamPlaybackPolyphonic, "play_stream", 1846744803)
    }
    
    args:=[?]rawptr{stream,
        from_offset,
        volume_db,
        pitch_scale,
        playback_type,
        bus,
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlayerPlyphonicplaystream, player, raw_data(args[:]), r_ret)
}


AudioStreamPlaybackPolyphonic_set_stream_volume :: proc(player: ^Object, stream: ^Int, volume_db: ^float) {
    @(static)AudioStreamPlaybackPolyphonicsetstreamvolume: GDE.MethodBindPtr
    if AudioStreamPlaybackPolyphonicsetstreamvolume == nil {
        AudioStreamPlaybackPolyphonicsetstreamvolume = classDBGetMethodBind3(.AudioStreamPlaybackPolyphonic, "set_stream_volume", 1602489585)
    }
    
    args:=[?]rawptr{stream,
        volume_db,
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlaybackPolyphonicsetstreamvolume, player, raw_data(args[:]), nil)
}


AudioStreamPlaybackPolyphonic_set_stream_pitch_scale :: proc(player: ^Object, stream: ^Int, pitch_scale: ^float) {
    @(static)AudioStreamPlaybackPolyphonicsetstreampitchscale: GDE.MethodBindPtr
    if AudioStreamPlaybackPolyphonicsetstreampitchscale == nil {
        AudioStreamPlaybackPolyphonicsetstreampitchscale = classDBGetMethodBind3(.AudioStreamPlaybackPolyphonic, "set_stream_pitch_scale", 1602489585)
    }
    
    args:=[?]rawptr{stream,
        pitch_scale,
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlaybackPolyphonicsetstreampitchscale, player, raw_data(args[:]), nil)
}


AudioStreamPlaybackPolyphonic_is_stream_playing :: proc(player: ^Object, stream: ^Int, r_bool: Bool) {
    @(static)AudioStreamPlaybackPolyphonicisstreamplaying: GDE.MethodBindPtr
    if AudioStreamPlaybackPolyphonicisstreamplaying == nil {
        AudioStreamPlaybackPolyphonicisstreamplaying = classDBGetMethodBind3(.AudioStreamPlaybackPolyphonic, "is_stream_playing", 1116898809)
    }
    
    args:=[?]rawptr{stream,
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlaybackPolyphonicisstreamplaying, player, raw_data(args[:]), nil)
}


AudioStreamPlaybackPolyphonic_stop_stream :: proc(player: ^Object, stream: ^Int) {
    @(static)AudioStreamPlaybackPolyphonicstopstream: GDE.MethodBindPtr
    if AudioStreamPlaybackPolyphonicstopstream == nil {
        AudioStreamPlaybackPolyphonicstopstream = classDBGetMethodBind3(.AudioStreamPlaybackPolyphonic, "stop_stream", 1286410249)
    }
    
    args:=[?]rawptr{stream,
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlaybackPolyphonicstopstream, player, raw_data(args[:]), nil)
}           

/**************************************/
/*****AudioStreamPlyphonic*****/
/**************************************/




AudioStreamPolyphonic_set_polyphony :: proc(player: ^Object, voices: ^Int) {
    @(static)AudioStreamPolyphonicsetpolyphony: GDE.MethodBindPtr
    if AudioStreamPolyphonicsetpolyphony == nil {
        AudioStreamPolyphonicsetpolyphony = classDBGetMethodBind3(.AudioStreamPolyphonic, "set_polyphony", 1286410249)
    }
    
    args:=[?]rawptr{voices,
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPolyphonicsetpolyphony, player, raw_data(args[:]), nil)
}


AudioStreamPolyphonic_get_polyphony :: proc(player: ^Object, r_voices: ^Int) {
    @(static)AudioStreamPolyphonicgetpolyphony: GDE.MethodBindPtr
    if AudioStreamPolyphonicgetpolyphony == nil {
        AudioStreamPolyphonicgetpolyphony = classDBGetMethodBind3(.AudioStreamPolyphonic, "get_polyphony", 3905245786)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPolyphonicgetpolyphony, player, nil, r_voices)
}

/***************************/
/*****AudioStreamPlayer*****/
/***************************/


AudioStreamPlayer_set_stream :: proc(player: ^Object, stream: ^^Object) {
    @(static)AudioStreamPlayersetstream: GDE.MethodBindPtr
    if AudioStreamPlayersetstream == nil {
        AudioStreamPlayersetstream = classDBGetMethodBind3(.AudioStreamPlayer, "set_stream", 2210767741)
    }

    args:= [?]rawptr {stream}

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlayersetstream, player, raw_data(args[:]), nil)
}


AudioStreamPlayer_play_default :: proc(player: ^Object) {
    from_position:float= 0
    AudioStreamPlayer_play(player, &from_position)
}


AudioStreamPlayer_play :: proc(player: ^Object, from_position: ^float = nil) {
    @(static)AudioStreamPlayerplay: GDE.MethodBindPtr
    if AudioStreamPlayerplay == nil {
        AudioStreamPlayerplay = classDBGetMethodBind3(.AudioStreamPlayer, "play", 1958160172)
    }
    call:= cast(proc(self: ^Object, from_position: ^float = nil))(cast(^MethodBind)AudioStreamPlayerplay).method
    call(player, from_position)
}

AudioStreamPlayer_get_stream :: proc(player: ^Object, r_stream: ^^Object) {
    @(static)AudioStreamPlayergetstream: GDE.MethodBindPtr
    if AudioStreamPlayergetstream == nil {
        AudioStreamPlayergetstream = classDBGetMethodBind3(.AudioStreamPlayer, "get_stream", 160907539)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlayergetstream, player, nil, r_stream)
}

AudioStreamPlayer_is_playing :: proc(player: ^Object, r_bool: ^Bool) {
    @(static)AudioStreamisplaying: GDE.MethodBindPtr
    if AudioStreamisplaying == nil {
        AudioStreamisplaying = classDBGetMethodBind3(.AudioStreamPlayer, "is_playing", 36873697)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamisplaying, player, nil, r_bool)
}

AudioStreamPlayer_is_playing_r :: proc(player: ^Object) -> (r_bool: Bool) {
    AudioStreamPlayer_is_playing(player, &r_bool)
    return
}

AudioStreamPlayer_stop :: proc(player: ^Object) {
    @(static)AudioStreamstop: GDE.MethodBindPtr
    if AudioStreamstop == nil {
        AudioStreamstop = classDBGetMethodBind3(.AudioStreamPlayer, "stop", 3218959716)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamstop, player, nil, nil)
}

/*********************/
/*****AudioStream*****/
/*********************/


AudioStream_get_length :: proc(player: ^Object, r_length: ^float) {
    @(static)AudioStreamgetlength: GDE.MethodBindPtr
    if AudioStreamgetlength == nil {
        AudioStreamgetlength = classDBGetMethodBind3(.AudioStream, "get_length", 1740695150)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamgetlength, player, nil, r_length)
}
//Player uses the same reference to a AudioStream as what is loaded.
//setting AudioStream before or after updating the source AudioStream's settings makes no difference.
//set loop methods must be used with either the AudioStream from get_audio_stream or the original AudioStream

WAV_LoopMode::enum i64 {
	LOOP_DISABLED,
	LOOP_FORWARD,
	LOOP_PINGPONG,
	LOOP_BACKWARD,
}
//If you are using WAV file you will need to calculate the length of the loop you want to make.
//After setting loop mode, you must set_loop_end.
AudioStreamWAV_set_loop_mode :: proc(player: ^Object, loop_mode: ^WAV_LoopMode) {
    @(static)AudioStreamWAVsetloopmode: GDE.MethodBindPtr
    if AudioStreamWAVsetloopmode == nil {
        AudioStreamWAVsetloopmode = classDBGetMethodBind3(.AudioStreamWAV, "set_loop_mode", 2444882972)
    }
    args:= [1]rawptr {loop_mode}

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamWAVsetloopmode, player, raw_data(args[:]), nil)
}

//set_loop_end is the position in the media based on the sample rate.
//44100 sample rate * 84 sections = 3_704_400 to loop end.
AudioStreamWAV_set_loop_end :: proc(player: ^Object, loop_end: ^Int) {
    @(static)AudioStreamWAVsetloopend: GDE.MethodBindPtr
    if AudioStreamWAVsetloopend == nil {
        AudioStreamWAVsetloopend = classDBGetMethodBind3(.AudioStreamWAV, "set_loop_end", 1286410249)
    }
    args:= [1]rawptr {loop_end}

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamWAVsetloopend, player, raw_data(args[:]), nil)
}

AudioStreamWAV_set_loop_begin :: proc(player: ^Object, loop_begin: ^Int) {
    @(static)AudioStreamWAVsetloopbegin: GDE.MethodBindPtr
    if AudioStreamWAVsetloopbegin == nil {
        AudioStreamWAVsetloopbegin = classDBGetMethodBind3(.AudioStreamWAV, "set_loop_begin", 1286410249)
    }
    args:= [1]rawptr {loop_begin}

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamWAVsetloopbegin, player, raw_data(args[:]), nil)
}

AudioStreamWAV_get_mix_rate :: proc(player: ^Object, r_mix_rate: ^Int) {
    @(static)AudioStreamWAVgetmixrate: GDE.MethodBindPtr
    if AudioStreamWAVgetmixrate == nil {
        AudioStreamWAVgetmixrate = classDBGetMethodBind3(.AudioStreamWAV, "get_mix_rate", 3905245786)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamWAVgetmixrate, player, nil, r_mix_rate)
}

//precision is to the second instead of exact duration.
AudioStreamWAV_calculate_loop_size :: proc(stream: ^Object) -> (r_value: Int) {
    AudioStreamWAV_get_mix_rate(stream, &r_value)
    length:float=0
    AudioStream_get_length(stream, &length)
    fmt.println(length)
    r_value*=Int(length)
    return
}


//Following the implementation of audio_stream_player once an audio stream have been instantiated you can call start and stop.
AudioStream__instantiate_playback :: proc(player: ^Object, AudioStreamPlayback: ^^Object) {
    @(static)AudioStreaminstantiateplayback: GDE.MethodBindPtr
    if AudioStreaminstantiateplayback == nil {
        AudioStreaminstantiateplayback = classDBGetMethodBind3(.AudioStream, "instantiate_playback", 210135309)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreaminstantiateplayback, player, nil, AudioStreamPlayback)
}


/*
//Alternative load.
//Read from file and then set the buffer directly.
//Benefits -> only one instance of the file needed no matter how many 'unique' settings in players there would be.
//Drawback -> Each instantiation of the stream will require manual updates to each field?
public AudioStreamMP3 LoadMP3(string path)
{
    using var file = FileAccess.Open(path, FileAccess.ModeFlags.Read);
    var sound = new AudioStreamMP3();
    sound.Data = file.GetBuffer(file.GetLength());
    return sound;
}
*/

/*****************************/
/*****AudioStreamPlayback*****/
/*****************************/
//You shouldn't need to do anything with these because you can't do anything with these.
//GDExtension does not have access to the audioServer's start playback method.
//If they ever expose the start_stream/sample methods from audioserver it may become useful.
//Yes AudioStreamPlayback has a play option but I think this is only used by the audioServer itself?
//AudioStreamPlaybackPolyphonic solves the problem of having a player for each sound.



AudioStreamPlayback__start :: proc(player: ^Object, from_pos: ^float) {
    @(static)AudioStreamPlaybackstart: GDE.MethodBindPtr
    if AudioStreamPlaybackstart == nil {
        AudioStreamPlaybackstart = classDBGetMethodBind3(.AudioStreamPlayback, "start", 1958160172)
    }

    args:= [?]rawptr {from_pos}

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlaybackstart, player, raw_data(args[:]), nil)
}

AudioStreamPlayback__stop :: proc(player: ^Object) {
    @(static)AudioStreamPlaybackstop: GDE.MethodBindPtr
    if AudioStreamPlaybackstop == nil {
        AudioStreamPlaybackstop = classDBGetMethodBind3(.AudioStreamPlayback, "stop", 3218959716)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlaybackstop, player, nil, nil)
}

AudioStreamPlayback_is_playing :: proc(player: ^Object, r_bool: ^Bool) {
    @(static)AudioStreamPlaybackisplaying: GDE.MethodBindPtr
    if AudioStreamPlaybackisplaying == nil {
        AudioStreamPlaybackisplaying = classDBGetMethodBind3(.AudioStreamPlayback, "is_playing", 36873697)
    }

    gdAPI.Object_Utils.MethodBindPtrcall(AudioStreamPlaybackisplaying, player, nil, r_bool)
}

/*
				{
					"name": "mix_audio",
					"is_const": false,
					"is_vararg": false,
					"is_static": false,
					"is_virtual": false,
					"hash": 3341291446,
					"return_value": {
						"type": "PackedVector2Array"
					},
					"arguments": [
						{
							"name": "rate_scale",
							"type": "float",
							"meta": "float"
						},
						{
							"name": "frames",
							"type": "int",
							"meta": "int32"
						}
					]
				},
				{*/