from kittens.tui.handler import result_handler
from kitty.boss import Boss


def main(args):
    pass


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss: Boss) -> None:
    w = boss.window_id_map.get(target_window_id)
    if w is None:
        return
    if w.has_selection():
        w.screen.clear_selection()
    else:
        w.write_to_child(b"\x1b")
