# grainsteel - system packages for grain (IDEA - future)

**team**: teamtreasure02 (taurus ♉ / II. the high priestess - building blocks)  
**purpose**: distribution-friendly wrapper for grain package manager  
**for**: brew, apt, nix, apk, pacman users  
**installs**: grain package manager for Steel modules  
**aliases**: `grain` (if safe) or `grainsteel` (always works)  
**status**: ⚠️ **IDEA** - defer until after Redox OS mastery! 🏔️  
**decomplection**: ✅ already decomplected with function-box-* pattern!  
**relationship**: wraps [grain-idea](https://github.com/teamtreasure02/grain-idea)

---

## hey! what is grainsteel?

**grainsteel** is the system package version of **grain** - our package manager for Steel modules!

**the problem:**
- `grain` might be taken in system package managers (brew/apt/nix)
- need a unique, conflict-free name
- want seamless user experience

**the solution:**
- install as `grainsteel` (unique name!)
- auto-alias to `grain` if safe
- smart setup script handles everything

**after setup, you just type `grain`!** 🌾

---

## ⚠️ why is this an IDEA?

**priority shift: Redox OS first!**

### the realization:

**package managers = convenience**  
**Redox OS = sovereignty foundation**

### the path:

1. **weeks 1-4**: master Redox OS (microkernel, Rust, capabilities!)
2. **weeks 5-8**: run grain modules on Redox natively
3. **weeks 9+**: optimize distribution with grain/grainsteel

### we can use grain modules TODAY without a package manager:

```bash
# clone and use directly:
git clone https://github.com/teamtreasure02/grainorder
cd grainorder
steel grainorder.scm  # works!
```

**grain PM makes it EASIER, not POSSIBLE!**

### when we return to this:

- we'll have Redox OS mastery
- we'll know what packaging ACTUALLY needs
- we'll build it right the first time
- we'll integrate with Redox's `pkg` manager

**deferred, not abandoned!** 🏔️⚒️

---

## relationship with grain-idea

**grainsteel** wraps **grain**:

```
grain-idea (core):
  - Rust CLI package manager
  - cargo install grain
  - clones modules from GitHub
  - manages ~/.grain/modules/

grainsteel-idea (wrapper):
  - bash scripts for system packages
  - brew/apt/nix/apk/pacman install grainsteel
  - runs: cargo install grain
  - creates alias: grain → grainsteel
  - smart conflict detection
```

**both are IDEAs until post-Redox!**

see: https://github.com/teamtreasure02/grain-idea

---

## quick install (FUTURE - when we build this!)

### homebrew (macOS/linux)
```bash
brew install grainsteel
grainsteel-setup
```

### apt (debian/ubuntu)
```bash
sudo apt install grainsteel
grainsteel-setup
```

### nix
```bash
nix-env -i grainsteel
grainsteel-setup
```

### alpine apk
```bash
apk add grainsteel
grainsteel-setup
```

### arch pacman
```bash
pacman -S grainsteel
grainsteel-setup
```

---

## what does grainsteel-setup do?

the setup script is **smart and helpful**! it:

1. **checks for steel** - is steel installed?
2. **checks for cargo** - is rust/cargo available?
3. **installs grain binary** - via `cargo install grain`
4. **checks for conflicts** - is `grain` command already taken?
5. **creates alias** - `grain → grainsteel` (if safe!)
6. **checks for grainzsh** - offers to install it
7. **sets environment** - `GRAIN_COMMAND=grainsteel` for compatibility

**it won't break your existing setup!** ⚒️

---

## decomplected design

grainsteel follows the **grain module convention**!

```
grainsteel/
├── grainsteel              (main wrapper script)
├── grainsteel-setup        (smart installer - coordinates everything!)
├── grainsteel-uninstall    (cleanup script)
├── function-box-detect.sh  (detection utilities 🎁)
├── function-box-install.sh (installation utilities 🎁)
├── readme.md               (this file!)
└── license*.md             (dual mit/apache!)
```

**function boxes contain:**
- `function-box-detect.sh` - all detection logic (steel? grain? grainzsh?)
- `function-box-install.sh` - all installation logic (aliases, env vars, etc)

**main scripts just coordinate!**
- `grainsteel-setup` - calls functions from boxes, handles user interaction
- `grainsteel-uninstall` - calls functions from boxes, cleans up

**this is decomplected!** each box has one job! ⚒️🎁

---

## usage examples

### after setup with alias:
```bash
# these all work!
grain install grainorder
grain install grainbuild
grain list
grain update
```

### without alias (if grain command exists):
```bash
grainsteel install grainorder
grainsteel install grainbuild
grainsteel list
grainsteel update
```

### the wrapper delegates to actual grain binary:
```bash
# grainsteel is just a wrapper!
# it calls the real 'grain' binary installed via cargo
which grain  # → ~/.cargo/bin/grain (installed via cargo)
which grainsteel  # → /usr/local/bin/grainsteel (system package)
```

---

## how it works

### installation flow:

1. **system package manager installs grainsteel**
   ```bash
   brew install grainsteel
   # installs: /usr/local/bin/grainsteel
   #           /usr/local/bin/grainsteel-setup
   #           /usr/local/bin/grainsteel-uninstall
   ```

2. **you run grainsteel-setup**
   ```bash
   grainsteel-setup
   # checks everything
   # installs grain via cargo
   # creates aliases
   ```

3. **now you have both!**
   ```bash
   which grainsteel  # → /usr/local/bin/grainsteel (system)
   which grain       # → ~/.cargo/bin/grain (cargo)
   alias grain       # → grain='grainsteel' (your shell)
   ```

### execution flow:

```
you type: grain install grainorder
         ↓
shell alias: grain='grainsteel'
         ↓
grainsteel wrapper: checks for grain binary
         ↓
grain binary: actual package manager (cargo install grain)
         ↓
installs grainorder module!
```

**it's like a smart proxy!** 🌾⚒️

---

## what's the difference?

### grain (cargo package)
- **install**: `cargo install grain`
- **binary**: `~/.cargo/bin/grain`
- **updates**: `cargo install grain --force`
- **uninstall**: `cargo uninstall grain`
- **requires**: rust/cargo

### grainsteel (system package)
- **install**: `brew install grainsteel` (or apt/nix/apk/pacman)
- **binary**: `/usr/local/bin/grainsteel`
- **updates**: `brew upgrade grainsteel` (or apt/nix/apk/pacman)
- **uninstall**: `brew uninstall grainsteel`
- **requires**: system package manager

### best of both worlds!

**for end users:**
- install via system package manager (familiar!)
- type `grain` (simple!)
- updates via system package manager (easy!)

**for developers:**
- install via cargo (rust native!)
- type `grain` (same!)
- contribute via rust (powerful!)

---

## smart conflict detection

grainsteel-setup checks for:

### existing 'grain' command
```bash
$ which grain
/usr/local/bin/grain  # some other tool!

# grainsteel-setup asks:
⚠️  "grain" command already exists!
   location: /usr/local/bin/grain

   options:
     1. use "grainsteel" as your command (no alias)
     2. create alias anyway (may conflict!)
     3. cancel setup

   choose (1/2/3):
```

### package manager conflicts
```bash
# grainsteel-setup checks:
brew list | grep grain
apt list | grep grain
nix-env -q | grep grain
# etc for all package managers

# if found:
⚠️  found 'grain' in: brew apt
   this may conflict with grainsteel!
```

**you're always in control!** ⚒️

---

## grainzsh integration

grainsteel works beautifully with **grainzsh**!

```bash
# grainsteel-setup offers to install grainzsh:
⚠️  grainzsh not found

   grainzsh provides:
     - auto steel installation
     - grain module path management
     - beautiful zsh config

   install grainzsh? (y/n)
```

**grainzsh features:**
- auto-detects grainsteel
- manages `$GRAIN_COMMAND` variable
- provides grain module completions
- beautiful prompt with grain status

---

## environment variables

grainsteel sets `GRAIN_COMMAND` for compatibility:

```bash
# in your ~/.zshrc (added by grainsteel-setup):
export GRAIN_COMMAND=grainsteel
```

**why?**

scripts can check:
```bash
${GRAIN_COMMAND:-grain} install grainorder
# uses $GRAIN_COMMAND if set, falls back to 'grain'
```

this makes our docs work for everyone:
- docs say: `grain install`
- works with: `grain` (alias) or `grainsteel` (direct)

**universal compatibility!** 🌾

---

## uninstall

### remove aliases and env vars:
```bash
grainsteel-uninstall
```

### remove grain binary (cargo):
```bash
cargo uninstall grain
```

### remove grainsteel (system):
```bash
brew uninstall grainsteel  # or apt/nix/apk/pacman
```

**clean removal, no cruft!** ⚒️

---

## module convention compliance

grainsteel follows the **grain module convention**!

✅ **flat structure** - no nested src/ folders  
✅ **function-box-*** - domain-specific utilities  
✅ **descriptive names** - `function-box-detect`, `function-box-install`  
✅ **glow g2 comments** - teaching through code  
✅ **decomplected** - each box has one job

**example from function-box-detect.sh:**
```bash
detect_steel() {
    # check if steel is installed
    # returns: 0 if found, 1 if not found
    
    if command -v steel >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}
```

**kid-friendly! educational! functional!** 🎁📚

---

## why grainsteel instead of just grain?

### namespace safety
- `grain` might exist in brew/apt/nix
- `grainsteel` is unique (grain + steel!)
- no conflicts, no confusion

### clear naming
- `grainsteel` = grain package manager for Steel
- SEO-friendly, discoverable
- tells you what it is!

### best user experience
- install as `grainsteel` (safe)
- use as `grain` (simple)
- win-win! 🌾⚒️

---

## roadmap

### phase 1: ✅ done!
- decomplected design
- function boxes (detect, install)
- smart setup script
- conflict detection
- grainzsh integration
- uninstall script

### phase 2: in progress
- brew formula
- debian package
- nix expression
- alpine apk
- arch pkgbuild

### phase 3: planned
- auto-update notifications
- health check command
- doctor command (diagnose issues)
- integration tests

---

## related projects

- **teamtreasure02/grain** - full package manager (this delegates to it!)
- **teamtreasure02/grainorder** - chronological file naming
- **teamtreasure02/grainbuild** - build system for grain modules
- **teamtreasure02/grain-steel-stdlib** - standard library extensions
- **teamprecision06/grainzsh** - zsh config with steel/grain support
- **teamshine05/graintime** - astronomical git branches

**all grain network!** 🌾⚒️🏔️

---

## full documentation

for complete grain documentation, see:
- **main repo**: https://github.com/teamtreasure02/grain
- **getting started**: see grain readme
- **steel language**: https://github.com/mattwparas/steel

---

## license

dual-licensed under your choice of:
- **mit license** - see [license-mit.md](license-mit.md)
- **apache license 2.0** - see [license-apache.md](license-apache.md)

you may use this software under either license, or under any other permissive open source license of your choosing, provided you include attribution to the original authors.

**we believe in maximum freedom for users and developers!** 🌾

---

now == next + 1 🌾

**grainsteel** - system-friendly packaging for grain! ⚒️🌾🚀

**install**: via your favorite package manager  
**use**: just type `grain` (or `grainsteel`)  
**enjoy**: seamless steel module management!

