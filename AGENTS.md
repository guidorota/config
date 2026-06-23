# Personal global config

Personal preferences and conventions only. Project-specific guidance
belongs in each project's own `CLAUDE.md`.

## About me

- I work primarily on macOS and Linux. Keep commands portable; flag any
  that are platform-specific (e.g. `open` vs `xdg-open`).
- Shell is zsh.

## How I like you to work

- Be concise. Lead with the answer or the change; keep preamble short.
- When a task is ambiguous and a reasonable default exists, pick it, state the
  assumption, and proceed — don't stall on questions.
- Show me the diff/command before running anything destructive or hard to reverse.
- When you finish, tell me plainly what you changed and what (if anything) you verified.
- Prefer plain ASCII; avoid emoji and box-drawing characters.

## Coding conventions

- Keep comments to a minimum. Don't restate the code, explain the "why" when needed.
- Match the existing style of the file/project over any global preference here.
- No speculative abstractions — solve the problem in front of us.
- Prefer small, focused changes. Don't reformat unrelated code in the same edit.

## Git & commits

- Don't commit or push unless I ask.
- Keep commit messages short and imperative ("Add X", "Fix Y").

## Things to avoid

- Don't introduce new dependencies without flagging it first.
- Don't leave TODOs or commented-out code behind.
