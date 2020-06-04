from i3ipc import Connection, Event

# Create the Connection object that can be used to send commands and subscribe
# to events.
i3 = Connection()

# Print the name of the focused window
# root = i3.get_tree()
# print(root.descendants())
# for node in root.nodes:
#       print(node)
# # print(tree)
# # focused = i3.get_tree().find_focused()
# # print('Focused window %s is on workspace %s' %
# #       (focused.name, focused.workspace().name))

# # Print the names of all the containers in the tree

# # Send a command to be executed synchronously.
# i3.command('focus left')

# print('fullScreen')
# # Take all fullscreen windows out of fullscreen
# for container in i3.get_tree().find_fullscreen():
#     container.command('fullscreen')


def example():
    print('---')
    root_window = i3.get_tree()
    result = [None]
    current_window = root_window.find_focused()

    current_workspace = current_window.workspace()
    for i, leaf in enumerate(current_workspace.leaves()):
        # .floating = {'user_on', 'auto_off'}
        if 'on' in leaf.floating:
            pass
            print(i, leaf.name, 'on:', leaf.floating)
        else:
            print(i, leaf.name, 'off', leaf.floating)
            rect = leaf.geometry
            width, height = rect.width, rect.height
            print(i, width, height)

# Dynamically name your workspaces after the current window class
def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    rect = focused.window_rect
    width, height = rect.width, rect.height
    print(focused.name, width, height)
    if width > height:
        i3.command('split h')
    else:
        i3.command('split v')

# def on_window_move(i3, e):
#     focused = i3.get_tree().find_focused()
#     current_workspace = focused.workspace()
#     for i, leaf in enumerate(current_workspace.leaves()):
#         if 'off' in leaf.floating:
#             print(i, leaf.name, 'off', leaf.floating)
#             rect = leaf.window_rect
#             width, height = rect.width, rect.height
#             print('  Geometry', width, height)
#             if width > height:
#                 i3.command('split h')
#             else:
#                 i3.command('split v')


#     current_workspace = focused.workspace()
#     for i, leaf in enumerate(current_workspace.leaves()):
#         # .floating = {'user_on', 'auto_off'}
#         if 'off' in leaf.floating:
#             print(i, leaf.name, 'off', leaf.floating)
#             rect = leaf.geometry
#             width, height = rect.width, rect.height
#             print(i, width, height)
#             if width > height:
#                 i3.command('split h')
#             else:
#                 i3.command('split v')
# #     ws_name = "%s:%s" % (focused.workspace().num, focused.window_class)
#     i3.command('rename workspace to "%s"' % ws_name)

i3.on(Event.WINDOW_FOCUS, on_window_focus)
# i3.on(Event.WINDOW_MOVE, on_window_move)
i3.main()
# print(current_window.ipc_data.keys())
# print(current_window.ipc_data['last_split_layout'])
# print(current_window.ipc_data['workspace_layout'])
# print(current_window.leaves())
# print(root_window.leaves())
# for i, leaf in enumerate(root_window.leaves()):
#       print(i, leaf.name)
# # for k, i in root_window.ipc_data.items():
# #       print(k, i)
# # print(root_window.parent)
# # def find_parent()
# # def finder(nodes, p=None):
# #       if result[0] is not None:
# #             return
# #       for node in nodes:
# #             node['id'] == 
# # print(root.name)
# # for i, con in enumerate(root):
# #     print(f'{i:02d}', con.name)


# # Query the ipc for outputs. The result is a list that represents the parsed
# # reply of a command like `i3-msg -t get_outputs`.
# outputs = i3.get_outputs()

# print('Active outputs:')

# for output in filter(lambda o: o.active, outputs):
#     print(output.name)
