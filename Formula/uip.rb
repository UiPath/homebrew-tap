class Uip < Formula
  desc "UiPath CLI for automation lifecycle management"
  homepage "https://github.com/UiPath/cli"
  version "0.2.1"
  url "https://registry.npmjs.org/@uipath/cli/-/cli-#{version}.tgz"
  sha256 "b0ea825f001edb848973d659485e6e53cb53ffe6da85a8d9e07af43afb41919a"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args

    # Expose the CLI at HOMEBREW_PREFIX/lib/node_modules/@uipath/cli so the
    # plugin resolver finds plugins (installed there by `uip install <tool>`).
    (lib/"node_modules/@uipath").mkpath
    ln_s libexec/"lib/node_modules/@uipath/cli",
         lib/"node_modules/@uipath/cli"

    # --preserve-symlinks-main keeps import.meta.url at the HOMEBREW_PREFIX
    # path instead of realpath'ing into the keg. Prepending node's opt bin
    # to PATH pins npm too, so `uip tools install` always targets brew's
    # prefix regardless of nvm/volta/system npm on the user's PATH.
    (bin/"uip").write <<~SH
      #!/bin/bash
      export PATH="#{Formula["node"].opt_bin}:$PATH"
      exec "#{Formula["node"].opt_bin}/node" --preserve-symlinks-main \\
        "#{HOMEBREW_PREFIX}/lib/node_modules/@uipath/cli/dist/index.js" "$@"
    SH
    chmod 0755, bin/"uip"
  end

  def caveats
    <<~EOS
      Plugins installed via `uip tools install <tool>` live in:
        #{HOMEBREW_PREFIX}/lib/node_modules/@uipath/

      They persist across `brew upgrade uip` so your plugin state is preserved.

      Remove a specific plugin (uip keeps working):
        uip tools uninstall <tool>

      Fully uninstall uip and all plugins:
        rm -rf "#{HOMEBREW_PREFIX}/lib/node_modules/@uipath" && brew uninstall uip
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uip --version")
  end
end
