# Java IDE Setup for Neovim

## Phase 1: JDTLS Core Setup ✅ COMPLETE

A comprehensive Java development environment has been configured with:

### Features Enabled
- ✅ **LSP (Language Server Protocol)** via nvim-jdtls
- ✅ **Code Completion** with JUnit 5, Mockito, AssertJ, Hamcrest
- ✅ **Gradle Multi-Module** project support
- ✅ **Spring Boot** optimizations
- ✅ **Lombok** support
- ✅ **Spock Framework** ready
- ✅ **Code Refactoring** (extract variable/method/constant)
- ✅ **Test Running** (JUnit 5 + Spock)
- ✅ **Inlay Hints** for parameter names
- ✅ **Auto-Import Organization**

---

## Installation & First Run

### 1. Apply Dotfiles
```bash
cd ~/rolfed_dotfiles
stow nvim
```

### 2. Install Dependencies
Open Neovim and run:
```vim
:Lazy sync
```

Mason will automatically install:
- `jdtls` (Java Language Server)

### 3. Install Test/Debug Bundles (Optional for Phase 2)
```vim
:MasonInstall java-debug-adapter java-test
```

### 4. Open a Java File
```bash
nvim ~/your-project/src/main/java/YourClass.java
```

JDTLS will:
- Auto-start for `.java` files
- Create a per-project workspace in `~/.local/share/nvim/jdtls-workspaces/`
- Index your Gradle dependencies
- Enable code completion and navigation

---

## Java-Specific Keybindings

### Code Organization
| Key | Action |
|-----|--------|
| `<leader>jo` | **Organize imports** |
| Auto on save | Organize imports on file save |

### Refactoring
| Key | Action |
|-----|--------|
| `<leader>jv` | **Extract variable** (normal/visual) |
| `<leader>jc` | **Extract constant** (normal/visual) |
| `<leader>jm` | **Extract method** (visual) |

### Testing (JUnit 5 + Spock)
| Key | Action |
|-----|--------|
| `<leader>jt` | **Run test class** |
| `<leader>jT` | **Run test method** at cursor |
| `<leader>jdt` | **Debug test class** |
| `<leader>jdT` | **Debug test method** |

### Project Management
| Key | Action |
|-----|--------|
| `<leader>jb` | **Build project** |
| `<leader>ju` | **Update project config** |
| `<leader>jg` | **Gradle compile (incremental)** |

### Standard LSP (from after/plugin/lsp.lua)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references (Telescope) |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>lf` | Format buffer |

---

## Configuration Files

### Created Files
1. **`lua/plugins/java.lua`**
   - Declares nvim-jdtls plugin
   - Lazy loads only for `.java` files

2. **`ftplugin/java.lua`** (Main Configuration)
   - JDTLS startup command
   - Per-project workspace isolation
   - Gradle + Maven support
   - Spring Boot optimizations
   - JUnit 5/Spock/Mockito completion
   - Java-specific keybindings
   - Test runner integration

### Modified Files
- **`lua/plugins/lsp.lua`**: Added `jdtls` to `ensure_installed`

---

## Testing Support

### JUnit 5
- Auto-completion for `@Test`, `@BeforeEach`, `@AfterEach`
- Static imports for `Assertions.*`, `Mockito.*`, `AssertJ.*`
- Run individual test methods with `<leader>jT`
- Run entire test class with `<leader>jt`

### Spock Framework
- Groovy file support (requires separate Groovy LSP if needed)
- Test running works via Gradle test task integration
- `given/when/then` block support

### Spring Boot Test
- Auto-completion for `@SpringBootTest`, `@WebMvcTest`, etc.
- Integration test support
- MockMvc and TestRestTemplate completions

---

## Workspace Management

### Per-Project Isolation
Each project gets its own workspace:
```
~/.local/share/nvim/jdtls-workspaces/
├── corvette-globalterms/
├── another-project/
└── my-service/
```

This prevents:
- Classpath conflicts between projects
- Gradle cache collisions
- Configuration interference

### Cleaning Workspaces
If JDTLS behaves unexpectedly:
```bash
rm -rf ~/.local/share/nvim/jdtls-workspaces/<project-name>
```
Restart Neovim to rebuild.

---

## Troubleshooting

### JDTLS Not Starting
1. Check Mason installation:
   ```vim
   :Mason
   ```
   Verify `jdtls` is installed (green checkmark)

2. Check logs:
   ```vim
   :LspInfo
   :LspLog
   ```

3. Check Java version:
   ```bash
   java -version  # Should be JDK 17+
   ```

### No Code Completion
1. Ensure project is a valid Gradle project (has `build.gradle` or `settings.gradle`)
2. Wait for initial indexing (watch bottom-right status)
3. Check LSP attachment: `:LspInfo`

### Gradle Build Errors
Update project configuration:
```vim
<leader>ju
```
Or rebuild from scratch:
```bash
cd your-project
./gradlew clean build
```
Then restart Neovim.

### Lombok Not Working
Lombok JAR is auto-configured in `ftplugin/java.lua`.
If issues persist:
```bash
ls ~/.local/share/nvim/mason/packages/jdtls/lombok.jar
```
Should exist. If not, reinstall jdtls:
```vim
:MasonUninstall jdtls
:MasonInstall jdtls
```

---

## Next Steps: Phase 2 (Debugging)

Phase 1 provides full IDE features except debugging. To add debugging:

### Phase 2 Prerequisites
```vim
:MasonInstall java-debug-adapter java-test
```

### Phase 2 Will Add
- Breakpoint debugging with `nvim-dap`
- Visual debugger UI
- Variable inspection
- Step through code
- Debug test methods

**Note:** Test running already works via `<leader>jt/jT`. Phase 2 adds *debugging* for tests.

---

## Customization

### Add Your JDK Runtime
Edit `ftplugin/java.lua`, lines ~90-98:
```lua
runtimes = {
  {
    name = "JavaSE-17",
    path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home",
    default = true,
  },
  {
    name = "JavaSE-21",
    path = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
  },
},
```

### Adjust Memory for Large Projects
Edit `ftplugin/java.lua`, line ~46:
```lua
'-Xmx2g',  -- Change to '-Xmx4g' for very large projects
```

### Disable Auto-Import on Save
Comment out lines 236-244 in `ftplugin/java.lua`:
```lua
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.java",
--   callback = function()
--     ...
--   end,
-- })
```

---

## Reference

- [nvim-jdtls GitHub](https://github.com/mfussenegger/nvim-jdtls)
- [eruizc.dev Java Guide](https://eruizc.dev/blog/en/java-with-neovim/)
- [JDTLS Settings](https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line)

---

**Status:** Phase 1 Complete ✅
**Next:** Phase 2 (Debugging) - Ready when you are!
