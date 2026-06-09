class Uip < Formula
  desc "UiPath CLI for automation lifecycle management"
  homepage "https://www.npmjs.com/package/@uipath/cli"
  version "1.195.0"
  url "https://registry.npmjs.org/@uipath/cli/-/cli-#{version}.tgz"
  sha256 "cd14046752de97449cf4d4ccd567504b4b4b108c3730202df2a9f409f2cfa8f2"

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
