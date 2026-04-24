class Uip < Formula
  desc "UiPath CLI for automation lifecycle management"
  homepage "https://github.com/UiPath/cli"
  version "0.9.0"
  url "https://registry.npmjs.org/@uipath/cli/-/cli-#{version}.tgz"
  sha256 "9f5d857a89ef350fcc27e308309b73035e1e3d80e428f4c9c5060f10e71155cc"

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
