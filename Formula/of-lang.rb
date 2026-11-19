class OfLang < Formula
  desc "Command-line tool for the OpenFjord modeling language"
  homepage "https://github.com/openfjord/of-lang"
  url "https://github.com/openfjord/of-lang/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "6d4240d8d8272dacec2adae558dd6565486b58c72181341587e0b8ec91da7554"
  license "Apache-2.0"
  head "https://github.com/openfjord/of-lang.git", branch: "main"

  depends_on "go" => :build

  def install
    cd "cli" do
      system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}"), "./cmd/of-lang"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/of-lang version")
    (testpath/"demo/package.yaml").write <<~YAML
      package: demo
      version: 0.1.0
      owner: demo
      rdfNamespace: https://example.com/demo#
    YAML
    (testpath/"demo/defs/dish.of.yaml").write <<~YAML
      Dish:
        is: Kind
        definition: A dish on the menu.
    YAML
    assert_equal "ok\n", shell_output("#{bin}/of-lang check #{testpath}/demo")
  end
end
