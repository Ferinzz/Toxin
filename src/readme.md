Taking from some examples from the UI demos here. https://github.com/godotengine/godot-demo-projects/tree/master/gui\


###rebind logic

First oddity comes with the VBoxContainer. You can search all you want for this class and not find it anywhere except the docs and the C++ code. What is it? It's a normal ass box_container class but with the constructor specifying that vertical is true or false. This controls the way it will be appending things.\

Other point is that the container functions on children. Not children that are part of a specific set of data. Nope. Direct children designated by the get_child* functions from Node.\

Looking at what is happening in this example. What is the role of GDE in here? I want to keep the design part of the program in the designer accessible sections. Meaning the UI layout will use the classes from Godot to structure itself.\

In that case what is left? Lowering the scope of what to do with GDE I can just go back to the basics of what was introduced in the C Example. Make a custom class. Instead of having the workflow to be to create a scene from a single button and a script the workflow could be to have a custom class for the rebind button. It would still need to inherit the whole button > control > canvasItem system but... Not sure what the total benefit is.\

For styling you need to set it via the inspector or via code. In the Inspector is Theme Overrides. In the code its add_theme_stylebox_override. Took far too long to make the link between that setting and what I was seeing in the tscn of the theming_override example. Spent a long time trying to figure out where it was used only to find that the main control node has a special kind of theme setting that applies globally to its children. I assume.\

Key note is that these are numbered. The number at the end of the theme res path is the id of the resource in the tscn. A resource can reference another resource by number within itself.\


```
[sub_resource type="Theme" id="5"]
Button/colors/font_color = Color(0.88, 0.88, 0.88, 1)
Button/colors/font_color_disabled = Color(0.9, 0.9, 0.9, 0.2)
Button/colors/font_color_hover = Color(0.94, 0.94, 0.94, 1)
Button/colors/font_color_pressed = Color(1, 1, 1, 1)
Button/constants/h_separation = 2
Button/fonts/font = null
Button/styles/disabled = null
Button/styles/focus = SubResource("1")
Button/styles/hover = SubResource("2")
Button/styles/normal = SubResource("3")
Button/styles/pressed = SubResource("4")
```


The override example is to show how you can specify the settings for buttons.\

This example uses signals to send up to the parent control node the notification that it was pressed. Then the parent sets the theme changes. This may be good practice for connecting to other entities in the tree and taking action on them.\

###DRAG and drop:
use control's _get_drag_data virtual to set the data that you will be sending to the other whatever which may receive it. return seems to be anything. in GDScript you set the return in the function declaration. In GDE it's just a variant.\
Also specify what will be the preview by calling set_drag_preview during the _get_drag_data function callback. The example generates a new control object and adds a color picker child to it to be able to render something.\
Docs say Shows the given control at the mouse pointer. A good time to call this method is in _get_drag_data(). The control must not be in the scene tree. You should not free the control, and you should not keep a reference to the control beyond the duration of the drag. It will be deleted automatically after the drag has ended. So don't heap allocate anything unless you're adding it to a specific custom class of your own with your own destruction property.\
_can_drop_data returns whether the value dropped is something that the destination can accept. It only provides the variant info, so more complex logic will need extra info in the variant that it passes.\
_drop_data accepts the data to process it however this particular object will want to process it.\


###RESIZING
Interesting note in the update container example.\
The code within this function needs to be run deferred to work around an issue with containers\
having a 1-frame delay with updates.\
Otherwise, `panel.size` returns a value of the previous frame, which results in incorrect\
sizing of the inner AspectRatioContainer when using the Fit to Window setting.\

This would be a good test to see how well call deferred could work? call_deferred (3776071444) is a Object method, so every class should have this. Specify the stringname of your registered function and it works? Also means you must register the function to the class DB for it to work.\

Overall this will be useful because understanding window resizing is usually one of the last things I look into XD\


###BiDi fonts
Kind of interesting? There's not a ton to do here it's mostly a demo about the various settings and what they achieve. Interesting aspect is the BiDi override setting. This allows you to change the default unicode orientation reading right to left text to instead be read left to right as it is for a filepath.\

Otherwise this is a bunch of the same. Many signals going up to the main control section where it will directly impact specific other objects in the tree. ie the slider sending a signal to control which will modify the VariableFontPreview object.\

###UI Mirror 
I don't really see working as intended. The main takazay is the fact that you can set the Container to be right to left or left to right. The localization options doesn't appear to do anything apparent.\
According to the TranslationServer it's supposed to be a root API that is meant to be used to offer localization features for users. It warns that it's mainly for making plugins. There's also a OS.get_locale() instead of the one in TranslationServer to get OS level data.\

###Translations
Maigc! It's just Magic! No not actually. It checks the end of a file name to determine if it's the translated version of the file that it was setup with. _en for english _es for when the locale is set to "es" etc. If you rename the file and REIMPORT (important because it will see the old import and reference to the same file) it will break the system.\
If there is no localized version of a file then it will use the default file. This is actually pretty good so that when someone is playing the game in another language it will be immediately apparent when something is missing instead of having a blank section.\

###PseudoLocalization
https://docs.godotengine.org/en/stable/tutorials/i18n/pseudolocalization.html
Basically just there to test out who the strings are being rendered. Would be good to make sure that the GDE is working as you want it. It's all project settings though. No need to do anything in the code itself unless you want to set some dev options in the game itself. Can update how strings are rendered dynamically? But needs a call to the TranslationServer.reload_pseudolocalization() so pretty nice.\