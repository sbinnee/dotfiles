#!/usr/bin/python
from i3ipc import Connection, Event
i3 = Connection()

def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    rect = focused.window_rect
    width, height = rect.width, rect.height
    # print(focused.name, width, height)
    if width > height:
        i3.command('split h')
    else:
        i3.command('split v')

i3.on(Event.WINDOW_FOCUS, on_window_focus)
i3.main()
