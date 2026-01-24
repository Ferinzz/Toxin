package GDWrapper

import "base:runtime"
import GDE "gdextension"
import sics "base:intrinsics"
import "core:slice"
import "core:reflect"
import "core:fmt"

AudioStream:: GDE.ObjectPtr

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

INVALID_ID:GDE.Int: -1

AudioStreamPlaybackPolyphonic_play_stream_default :: proc(player: GDE.ObjectPtr, stream: ^AudioStream, r_ret: ^GDE.Int) {
    from_offset:GDE.float= 0
    volume_db:GDE.float= 0
    pitch_scale:GDE.float= 1
    playback_type:GDE.PlaybackType= .PLAYBACK_TYPE_DEFAULT
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
AudioStreamPlaybackPolyphonic_play_stream :: proc(player: GDE.ObjectPtr, stream: ^AudioStream, from_offset: ^GDE.float,
    volume_db: ^GDE.float, pitch_scale: ^GDE.float, playback_type: ^GDE.PlaybackType, bus: ^GDE.StringName, r_ret: ^GDE.Int) {
    @(static)AudioStreamPlayerPlyphonicplaystream: GDE.MethodBindPtr
    if AudioStreamPlayerPlyphonicplaystream == nil {
        AudioStreamPlayerPlyphonicplaystream = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlaybackPolyphonic), "play_stream", 1846744803)
    }
    
    args:=[?]rawptr{stream,
        from_offset,
        volume_db,
        pitch_scale,
        playback_type,
        bus,
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPlayerPlyphonicplaystream, player, raw_data(args[:]), r_ret)
}


AudioStreamPlaybackPolyphonic_set_stream_volume :: proc(player: GDE.ObjectPtr, stream: ^GDE.Int, volume_db: ^GDE.float) {
    @(static)AudioStreamPlaybackPolyphonicsetstreamvolume: GDE.MethodBindPtr
    if AudioStreamPlaybackPolyphonicsetstreamvolume == nil {
        AudioStreamPlaybackPolyphonicsetstreamvolume = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlaybackPolyphonic), "set_stream_volume", 1602489585)
    }
    
    args:=[?]rawptr{stream,
        volume_db,
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPlaybackPolyphonicsetstreamvolume, player, raw_data(args[:]), nil)
}


AudioStreamPlaybackPolyphonic_set_stream_pitch_scale :: proc(player: GDE.ObjectPtr, stream: ^GDE.Int, pitch_scale: ^GDE.float) {
    @(static)AudioStreamPlaybackPolyphonicsetstreampitchscale: GDE.MethodBindPtr
    if AudioStreamPlaybackPolyphonicsetstreampitchscale == nil {
        AudioStreamPlaybackPolyphonicsetstreampitchscale = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlaybackPolyphonic), "set_stream_pitch_scale", 1602489585)
    }
    
    args:=[?]rawptr{stream,
        pitch_scale,
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPlaybackPolyphonicsetstreampitchscale, player, raw_data(args[:]), nil)
}


AudioStreamPlaybackPolyphonic_is_stream_playing :: proc(player: GDE.ObjectPtr, stream: ^GDE.Int, r_bool: GDE.Bool) {
    @(static)AudioStreamPlaybackPolyphonicisstreamplaying: GDE.MethodBindPtr
    if AudioStreamPlaybackPolyphonicisstreamplaying == nil {
        AudioStreamPlaybackPolyphonicisstreamplaying = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlaybackPolyphonic), "is_stream_playing", 1116898809)
    }
    
    args:=[?]rawptr{stream,
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPlaybackPolyphonicisstreamplaying, player, raw_data(args[:]), nil)
}


AudioStreamPlaybackPolyphonic_stop_stream :: proc(player: GDE.ObjectPtr, stream: ^GDE.Int) {
    @(static)AudioStreamPlaybackPolyphonicstopstream: GDE.MethodBindPtr
    if AudioStreamPlaybackPolyphonicstopstream == nil {
        AudioStreamPlaybackPolyphonicstopstream = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlaybackPolyphonic), "stop_stream", 1286410249)
    }
    
    args:=[?]rawptr{stream,
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPlaybackPolyphonicstopstream, player, raw_data(args[:]), nil)
}           

/**************************************/
/*****AudioStreamPlyphonic*****/
/**************************************/




AudioStreamPolyphonic_set_polyphony :: proc(player: GDE.ObjectPtr, voices: ^GDE.Int) {
    @(static)AudioStreamPolyphonicsetpolyphony: GDE.MethodBindPtr
    if AudioStreamPolyphonicsetpolyphony == nil {
        AudioStreamPolyphonicsetpolyphony = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPolyphonic), "set_polyphony", 1286410249)
    }
    
    args:=[?]rawptr{voices,
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPolyphonicsetpolyphony, player, raw_data(args[:]), nil)
}


AudioStreamPolyphonic_get_polyphony :: proc(player: GDE.ObjectPtr, r_voices: ^GDE.Int) {
    @(static)AudioStreamPolyphonicgetpolyphony: GDE.MethodBindPtr
    if AudioStreamPolyphonicgetpolyphony == nil {
        AudioStreamPolyphonicgetpolyphony = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPolyphonic), "get_polyphony", 3905245786)
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPolyphonicgetpolyphony, player, nil, r_voices)
}

/***************************/
/*****AudioStreamPlayer*****/
/***************************/


AudioStreamPlayer_set_stream :: proc(player: GDE.ObjectPtr, stream: ^GDE.ObjectPtr) {
    @(static)AudioStreamPlayersetstream: GDE.MethodBindPtr
    if AudioStreamPlayersetstream == nil {
        AudioStreamPlayersetstream = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlayer), "set_stream", 2210767741)
    }

    args:= [?]rawptr {stream}

    gdAPI.objectMethodBindPtrCall(AudioStreamPlayersetstream, player, raw_data(args[:]), nil)
}


AudioStreamPlayer_play_default :: proc(player: GDE.ObjectPtr) {
    from_position:GDE.float= 0
    AudioStreamPlayer_play(player, &from_position)
}


AudioStreamPlayer_play :: proc(player: GDE.ObjectPtr, from_position: ^GDE.float = nil) {
    @(static)AudioStreamPlayerplay: GDE.MethodBindPtr
    if AudioStreamPlayerplay == nil {
        AudioStreamPlayerplay = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlayer), "play", 1958160172)
    }
    args:= [1]rawptr{from_position}

    gdAPI.objectMethodBindPtrCall(AudioStreamPlayerplay, player, raw_data(args[:]), nil)
}

AudioStreamPlayer_get_stream :: proc(player: GDE.ObjectPtr, r_stream: ^GDE.ObjectPtr) {
    @(static)AudioStreamPlayergetstream: GDE.MethodBindPtr
    if AudioStreamPlayergetstream == nil {
        AudioStreamPlayergetstream = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlayer), "get_stream", 160907539)
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPlayergetstream, player, nil, r_stream)
}

AudioStreamPlayer_is_playing :: proc(player: GDE.ObjectPtr, r_bool: ^GDE.Bool) {
    @(static)AudioStreamisplaying: GDE.MethodBindPtr
    if AudioStreamisplaying == nil {
        AudioStreamisplaying = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlayer), "is_playing", 36873697)
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamisplaying, player, nil, r_bool)
}

AudioStreamPlayer_is_playing_r :: proc(player: GDE.ObjectPtr) -> (r_bool: GDE.Bool) {
    AudioStreamPlayer_is_playing(player, &r_bool)
    return
}

AudioStreamPlayer_stop :: proc(player: GDE.ObjectPtr) {
    @(static)AudioStreamstop: GDE.MethodBindPtr
    if AudioStreamstop == nil {
        AudioStreamstop = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlayer), "stop", 3218959716)
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamstop, player, nil, nil)
}

/*****************************/
/*****AudioStreamPlayback*****/
/*****************************/
//You shouldn't need to do anything with these because you can't do anything with these.
//GDExtension does not have access to the audioServer's start playback method.
//If they ever expose the start_stream/sample methods from audioserver it may become useful.
//Yes AudioStreamPlayback has a play option but I think this is only used by the audioServer itself?
//AudioStreamPlaybackPolyphonic solves the problem of having a player for each sound.


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

AudioStreamPlayback__start :: proc(player: GDE.ObjectPtr, from_pos: ^GDE.float) {
    @(static)AudioStreamPlaybackstart: GDE.MethodBindPtr
    if AudioStreamPlaybackstart == nil {
        AudioStreamPlaybackstart = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlayback), "start", 1958160172)
    }

    args:= [?]rawptr {from_pos}

    gdAPI.objectMethodBindPtrCall(AudioStreamPlaybackstart, player, raw_data(args[:]), nil)
}

AudioStreamPlayback__stop :: proc(player: GDE.ObjectPtr) {
    @(static)AudioStreamPlaybackstop: GDE.MethodBindPtr
    if AudioStreamPlaybackstop == nil {
        AudioStreamPlaybackstop = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlayback), "stop", 3218959716)
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPlaybackstop, player, nil, nil)
}

AudioStreamPlayback_is_playing :: proc(player: GDE.ObjectPtr, r_bool: ^GDE.Bool) {
    @(static)AudioStreamPlaybackisplaying: GDE.MethodBindPtr
    if AudioStreamPlaybackisplaying == nil {
        AudioStreamPlaybackisplaying = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamPlayback), "is_playing", 36873697)
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamPlaybackisplaying, player, nil, r_bool)
}


/*********************/
/*****AudioStream*****/
/*********************/


AudioStream_get_length :: proc(player: GDE.ObjectPtr, r_length: ^GDE.float) {
    @(static)AudioStreamgetlength: GDE.MethodBindPtr
    if AudioStreamgetlength == nil {
        AudioStreamgetlength = classDBGetMethodBind2(GDClass_StringName_get(.AudioStream), "get_length", 1740695150)
    }

    gdAPI.objectMethodBindPtrCall(AudioStreamgetlength, player, nil, r_length)
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
AudioStreamWAV_set_loop_mode :: proc(player: GDE.ObjectPtr, loop_mode: ^WAV_LoopMode) {
    @(static)AudioStreamWAVsetloopmode: GDE.MethodBindPtr
    if AudioStreamWAVsetloopmode == nil {
        AudioStreamWAVsetloopmode = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamWAV), "set_loop_mode", 2444882972)
    }
    args:= [1]rawptr {loop_mode}

    gdAPI.objectMethodBindPtrCall(AudioStreamWAVsetloopmode, player, raw_data(args[:]), nil)
}

//set_loop_end is the position in the media based on the sample rate.
//44100 sample rate * 84 sections = 3_704_400 to loop end.
AudioStreamWAV_set_loop_end :: proc(player: GDE.ObjectPtr, loop_end: ^GDE.Int) {
    @(static)AudioStreamWAVsetloopend: GDE.MethodBindPtr
    if AudioStreamWAVsetloopend == nil {
        AudioStreamWAVsetloopend = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamWAV), "set_loop_end", 1286410249)
    }
    args:= [1]rawptr {loop_end}

    gdAPI.objectMethodBindPtrCall(AudioStreamWAVsetloopend, player, raw_data(args[:]), nil)
}

AudioStreamWAV_set_loop_begin :: proc(player: GDE.ObjectPtr, loop_begin: ^GDE.Int) {
    @(static)AudioStreamWAVsetloopbegin: GDE.MethodBindPtr
    if AudioStreamWAVsetloopbegin == nil {
        AudioStreamWAVsetloopbegin = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamWAV), "set_loop_begin", 1286410249)
    }
    args:= [1]rawptr {loop_begin}

    gdAPI.objectMethodBindPtrCall(AudioStreamWAVsetloopbegin, player, raw_data(args[:]), nil)
}

AudioStreamWAV_get_mix_rate :: proc(player: GDE.ObjectPtr, r_mix_rate: ^GDE.Int) {
    @(static)AudioStreamWAVgetmixrate: GDE.MethodBindPtr
    if AudioStreamWAVgetmixrate == nil {
        AudioStreamWAVgetmixrate = classDBGetMethodBind2(GDClass_StringName_get(.AudioStreamWAV), "get_mix_rate", 3905245786)
    }
    args:= [1]rawptr {r_mix_rate}

    gdAPI.objectMethodBindPtrCall(AudioStreamWAVgetmixrate, player, nil, r_mix_rate)
}

//precision is to the second instead of exact duration.
AudioStreamWAV_calculate_loop_size :: proc(stream: GDE.ObjectPtr) -> (r_value: GDE.Int) {
    AudioStreamWAV_get_mix_rate(stream, &r_value)
    length:GDE.float=0
    AudioStream_get_length(stream, &length)
    fmt.println(length)
    r_value*=GDE.Int(length)
    return
}


//Following the implementation of audio_stream_player once an audio stream have been instantiated you can call start and stop.
AudioStream__instantiate_playback :: proc(player: GDE.ObjectPtr, AudioStreamPlayback: ^GDE.ObjectPtr) {
    @(static)AudioStreaminstantiateplayback: GDE.MethodBindPtr
    if AudioStreaminstantiateplayback == nil {
        AudioStreaminstantiateplayback = classDBGetMethodBind2(GDClass_StringName_get(.AudioStream), "instantiate_playback", 210135309)
    }

    gdAPI.objectMethodBindPtrCall(AudioStreaminstantiateplayback, player, nil, AudioStreamPlayback)
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


