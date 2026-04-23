class Uip < Formula
  desc "UiPath CLI for automation lifecycle management"
  homepage "https://github.com/UiPath/cli"
  version "0.2.2"
  url "https://registry.npmjs.org/@uipath/cli/-/cli-#{version}.tgz"
  sha256 "a68980d1a1be535eec21f0535fc9dc5b3f6832bb83554f25f9273457a860d2b8"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Plugins installed via `uip tools install <tool>` are written to npm's
      global prefix (`npm root -g`) and persist across `brew upgrade uip`.

      Remove a specific plugin:   uip tools uninstall <tool>
      Fully uninstall:            brew uninstall uip && rm -rf "$(npm root -g)/@uipath"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uip --version")
  end
end
