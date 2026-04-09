class Uip < Formula
  desc "UiPath CLI for automation lifecycle management"
  homepage "https://github.com/UiPath/cli"
  url "https://registry.npmjs.org/@uipath/cli/-/cli-0.1.21.tgz"
  sha256 "4d6eb6abe8f84a7546f110342081f164e88fc90a79e3df2573686ff8df64e238"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uip --version")
  end
end
