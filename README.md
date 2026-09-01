# Hormozi Skills

Two Agent Skills that turn Alex Hormozi's **$100M Offers** and **$100M Leads** methods into repeatable processes your AI agent can run.

| Skill | What it does | Output |
|---|---|---|
| `100m-offers` | Builds or critiques an offer: market, dream outcome, value equation, problem/solution stack, pricing, scarcity and urgency, guarantee, naming | An **Offer Brief** you can take into a sales page, deck, or call |
| `100m-leads` | Builds or critiques a lead-generation plan: lead magnet, the Core Four channels, volume commitment, unit-economics math, scaling, lead getters | A **Leads Brief** ending in a one-page advertising plan |

Both work in two modes. Give them an idea and they build from scratch. Paste an existing sales page, pricing table, ad, or DM script and they score it against a rubric, then rebuild the weak parts.

You do not need to say "Hormozi" or name the skill. Ask "what should I charge for this" or "my pipeline is dry" and a skills-aware agent loads the right one on its own.

---

## Install

Pick the section for your tool. Everything here is just files in a folder, so all methods are equivalent, and uninstalling means deleting the folder.

### Option A: one command (Claude Code, Codex CLI, Cursor)

```bash
git clone https://github.com/Gaiant-bill/hormozi-skills.git
cd hormozi-skills
./install.sh
```

With no argument the script detects which agents you have and installs to each of them. To target one:

```bash
./install.sh claude    # ~/.claude/skills
./install.sh codex     # ~/.agents/skills
./install.sh cursor    # ~/.cursor/skills
./install.sh agents    # ~/.agents/skills, the shared standard location
```

To install into a specific repo instead of your whole machine, so everyone who clones that repo gets them:

```bash
./install.sh project /path/to/repo
```

Restart your agent afterwards. Then type `/100m-offers` or `/100m-leads`, or just describe your problem.

### Option B: copy the folders by hand

Each skill is a self-contained folder. Drop it in the right place and the agent finds it.

| Tool | Personal (all projects) | Project (that repo only) |
|---|---|---|
| Claude Code | `~/.claude/skills/` | `.claude/skills/` |
| Codex CLI | `~/.agents/skills/` | `.agents/skills/` |
| Cursor | `~/.cursor/skills/` or `~/.agents/skills/` | `.cursor/skills/` or `.agents/skills/` |
| Any other Agent Skills client | check its docs, usually `~/.agents/skills/` | usually `.agents/skills/` |

```bash
cp -R skills/100m-offers skills/100m-leads ~/.claude/skills/
```

Cursor also reads `~/.claude/skills/` and `~/.codex/skills/` for compatibility, so if you already installed for Claude Code, Cursor picks them up too.

### Option C: Claude app (claude.ai, desktop, and Cowork)

Claude Code reads skills from your machine. The Claude app does not, it reads the skills enabled on your Claude account, so these have to be uploaded once as ZIP files.

1. Download [`dist/100m-offers.zip`](dist/100m-offers.zip) and [`dist/100m-leads.zip`](dist/100m-leads.zip) from this repo.
2. In the Claude desktop app or on claude.ai, go to **Customize > Skills**.
3. Click **+**, then **+ Create skill**, then **Upload a skill**.
4. Upload one ZIP. Repeat for the second.

They appear in your skills list with a toggle. Once enabled they are available in normal Claude chats and in Cowork sessions, on every device you sign in from.

Available on Free, Pro, Max, Team and Enterprise plans. On Team and Enterprise, a skill you upload yourself stays private to your account, an admin has to provision it through organization settings to give it to the whole company.

### Option D: Codex CLI specifics

Codex reads skills from `$HOME/.agents/skills` for you personally, and from `.agents/skills` in the repo (plus parent directories up to the repo root) for a project. `./install.sh codex` writes to the first. Codex picks up changes automatically. If a new skill does not show up, restart Codex, then check with `/skills`.

---

## Verify it worked

Start your agent in a fresh session and run one of these:

- Type `/100m-offers` and confirm it appears in the autocomplete list.
- Or ask, without naming anything: *"I run a 3-person bookkeeping firm charging $400 a month and nobody is buying. What should my offer be?"* The agent should start working through market, dream outcome, and value equation rather than giving generic advice.
- In Claude Code, `/skills` lists everything loaded and where it came from.

If nothing shows up, the usual causes are: the folder went to the wrong path, the agent was not restarted, or `SKILL.md` got renamed. The folder name is what becomes the command, so `100m-offers/SKILL.md` gives you `/100m-offers`.

---

## Updating

```bash
cd hormozi-skills
git pull
./install.sh
```

The installer overwrites the two skill folders in place and leaves everything else alone. If you uploaded to claude.ai, run `./make-zips.sh` and re-upload, or download the ZIPs from this repo again.

---

## Repo layout

```
skills/
  100m-offers/
    SKILL.md                 the process the agent follows
    references/              frameworks, enhancers, intake questions, critique rubric
    assets/                  the Offer Brief template
  100m-leads/
    SKILL.md
    references/              lead magnets, warm and cold outreach, content, paid ads, scaling, lead getters, rubric
    assets/                  the Leads Brief template
dist/                        zipped skills for uploading to claude.ai
install.sh                   installer for Claude Code, Codex, Cursor, or a project
make-zips.sh                 rebuilds the ZIPs after you edit a skill
```

`SKILL.md` holds only the process. The heavy reference material sits in `references/` and loads on demand, so having both skills installed costs almost nothing in context until one is actually used.

## Editing them

These are plain markdown. Change the wording, swap in your own pricing rules, add your industry's benchmarks. Keep the YAML frontmatter at the very top of `SKILL.md` with its `name` and `description` fields intact, since that is what every client reads to decide when to trigger the skill, and the opening `---` has to be the first line of the file.

## Compatibility

Built on the [Agent Skills](https://agentskills.io) open format: a folder with a `SKILL.md` that carries `name` and `description` in YAML frontmatter. That format is supported by Claude, Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, VS Code, OpenCode, Goose, Amp and others, so these two skills are portable well beyond the tools listed above.

## Attribution and disclaimer

The methods are Alex Hormozi's, from *$100M Offers* (Acquisition.com, 2021) and *$100M Leads* (Acquisition.com Volume II, 2023). This repo is an independent, unofficial implementation of those frameworks as agent instructions. It is not affiliated with, endorsed by, or produced by Alex Hormozi or Acquisition.com. Buy the books, they are the source.

The MIT license covers the skill files in this repo, not the underlying frameworks.

## Sources

Install paths and upload steps in this README come from official documentation, current as of September 2026:

- [Claude Code skills documentation](https://code.claude.com/docs/en/skills)
- [Getting started with Skills (Claude support)](https://support.claude.com/en/articles/12512180-getting-started-with-skills)
- [Codex skills documentation](https://developers.openai.com/codex/skills)
- [Cursor skills documentation](https://cursor.com/docs/context/skills)
- [Agent Skills open standard](https://agentskills.io)
