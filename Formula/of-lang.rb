class OfLang < Formula
  desc "Command-line tool for the OpenFjord modeling language"
  homepage "https://github.com/openfjord/of-lang"
  url "https://github.com/openfjord/of-lang/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4006d0863009736411668313e43bba98e93731968f64e1bd0bada942d8c40b3f"
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
