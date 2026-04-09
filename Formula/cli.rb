class Cli < Formula
  desc "UiPath CLI for automation lifecycle management"
  homepage "https://github.com/UiPath/cli"
  url "https://registry.npmjs.org/@uipath/cli/-/cli-0.1.21.tgz"
  sha256 "4d6eb6abe8f84a7546f110342081f164e88fc90a79e3df2573686ff8df64e238"

  depends_on "node"

  def install
    system "npm", "install", "-g", "."
    bin.install Dir["#{HOMEBREW_PREFIX}/bin/uip"]
  end

  def post_uninstall
    system "npm", "uninstall", "-g", "@uipath/cli"

    # Remove auto-installed plugin tools
    uipath_tools = %w[
      @uipath/solution-tool
      @uipath/agent-tool
      @uipath/codedagent-tool
      @uipath/codedapp-tool
      @uipath/integrationservice-tool
      @uipath/orchestrator-tool
      @uipath/rpa-tool
      @uipath/flow-tool
      @uipath/case-tool
      @uipath/test-manager-tool
      @uipath/resource-tool
      @uipath/api-workflow-tool
      @uipath/maestro-tool
      @uipath/docsai-tool
      @uipath/vertical-solutions-tool
      @uipath/traces-tool
    ]
    uipath_tools.each do |tool|
      system "npm", "uninstall", "-g", tool
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uip --version")
  end
end
