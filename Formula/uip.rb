class Uip < Formula
  desc "UiPath CLI for automation lifecycle management"
  homepage "https://github.com/UiPath/cli"
  url "https://registry.npmjs.org/@uipath/cli/-/cli-0.1.21.tgz"
  sha256 "4d6eb6abe8f84a7546f110342081f164e88fc90a79e3df2573686ff8df64e238"

  depends_on "node"

  def install
    system "npm", "install", "-g", "@uipath/cli@#{version}"
    (prefix/"RELEASE").write "@uipath/cli@#{version}\n"
  end

  def post_uninstall
    uipath_dir = "#{HOMEBREW_PREFIX}/lib/node_modules/@uipath"
    if Dir.exist?(uipath_dir)
      rm_rf uipath_dir
    end

    uip_bin = "#{HOMEBREW_PREFIX}/bin/uip"
    rm_f uip_bin if File.exist?(uip_bin)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uip --version")
  end
end
