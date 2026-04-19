#!/usr/bin/env python3
"""
iTerm2 auto-layout: portrait stacks panes, landscape spreads them side by side.

  Portrait  (height > width)  → horizontal splits (panes stacked)
  Landscape (width >= height) → vertical splits   (panes side by side)

Install
-------
1. Copy this file to:
   ~/Library/Application Support/iTerm2/Scripts/AutoLaunch/orient_panes.py

2. In iTerm2: Scripts ▸ AutoLaunch ▸ orient_panes.py  (toggle on)
   Or just restart iTerm2 — AutoLaunch scripts run automatically on startup.

Notes
-----
- Pane count and terminal contents are fully preserved across layout switches.
  Sessions are rearranged using App.async_move_session (no close/reopen).
- Only the active tab of each window is affected on each orientation change.
- Window orientation is polled every 250 ms; no work is done when unchanged.
"""

import asyncio
import iterm2

# window_id → last known orientation ("landscape" | "portrait")
_state: dict[str, str] = {}


def _orientation(frame) -> str:
    return "landscape" if frame.size.width >= frame.size.height else "portrait"


async def _rearrange(tab: iterm2.Tab, vertical: bool, app: iterm2.App) -> None:
    """
    Rearrange all sessions in *tab* using *vertical* splits, preserving their
    terminal state.

    vertical=True  → portrait→landscape: sorted top-to-bottom, arranged left-to-right
    vertical=False → landscape→portrait: sorted left-to-right, arranged top-to-bottom
    """
    sessions = list(tab.sessions)  # snapshot before the tree mutates
    count = len(sessions)
    if count <= 1:
        return

    # Fetch each session's on-screen frame so we can sort by position.
    frames = {}
    for s in sessions:
        try:
            frames[s.session_id] = await s.async_get_frame()
        except Exception:
            frames[s.session_id] = None

    def origin(s, attr):
        f = frames.get(s.session_id)
        return getattr(f.origin, attr) if f else 0

    if vertical:
        # portrait → landscape: collect top-to-bottom, arrange left-to-right.
        # macOS y-axis grows upward, so highest y = topmost pane.
        sessions.sort(key=lambda s: origin(s, "y"), reverse=True)
    else:
        # landscape → portrait: collect left-to-right, arrange top-to-bottom.
        sessions.sort(key=lambda s: origin(s, "x"))

    # Chain each session alongside the previous one in the desired direction.
    # before=False → each session goes to the right of / below its predecessor.
    for i in range(1, count):
        await app.async_move_session(
            sessions[i],
            sessions[i - 1],
            split_vertically=vertical,
            before=not vertical,
        )


async def _check_window(window: iterm2.Window, app: iterm2.App) -> None:
    frame = await window.async_get_frame()
    wid = window.window_id
    orient = _orientation(frame)

    if _state.get(wid) == orient:
        return  # Orientation unchanged — nothing to do

    _state[wid] = orient

    tab = window.current_tab
    if tab is None or len(tab.sessions) <= 1:
        return

    await _rearrange(tab, vertical=(orient == "landscape"), app=app)


async def main(connection):
    app = await iterm2.async_get_app(connection)

    # Seed initial orientations without triggering a rearrangement
    for window in app.windows:
        try:
            frame = await window.async_get_frame()
            _state[window.window_id] = _orientation(frame)
        except Exception:
            pass

    while True:
        await asyncio.sleep(0.25)
        for window in app.windows:
            try:
                await _check_window(window, app)
            except Exception:
                pass  # Window may have closed mid-check


iterm2.run_forever(main)
