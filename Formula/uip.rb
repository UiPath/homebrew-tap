class Uip < Formula
  desc "UiPath CLI for automation lifecycle management"
  homepage "https://github.com/UiPath/cli"
  version "0.2.0"
  url "https://registry.npmjs.org/@uipath/cli/-/cli-#{version}.tgz"
  sha256 "8f9ee91c60eacfdd1b7f378cdbee19d078010cb36d5886dc26ef72b30c187143"

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
