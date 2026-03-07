package main

main :: proc() {

    //~ args:
    //~ * specific test, by directory
    //~ * adjust output, file or cmd
    //~ * adjust file output location
    //~ * custom test package location
    //~ * custom test project location
    //~ * godot env arg or path

    //~ get list of directories matching test arg, or all
    //~ * to_lower?
    //~ * how specific should it be? suggest correction for 80% match.
    //~ loop begin
    //~ find directory
    //~ compile directory into test project
    //~ if compile errors
    //~   log
    //~   continue loop
    //~ else run test
    //~ run editor --headless
    //~ run game --headless
    //~ get logs of errors/warnings
    //~ close game when signaled (maybe includes a signal with a callback to this process somehow?)
    //~ continue
}
