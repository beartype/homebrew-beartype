class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/6b/c7/a73fbaa2f2abc1120e6d16cfb89cdb6f7ea3ba8e715dbc324ac1aafe7b4b/beartype-0.9.0.tar.gz"
  sha256 "a94691716c246a25a56e8a23942796b3133b5f444d92c1620329b81671be1311"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.8.1"
    sha256 cellar: :any_skip_relocation, catalina:     "7c0ff6ea7c40d8754133d69aa8a636705cf21ca0e42405fd7b4e1c5ddffb4343"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "93b245a1a4e420d0b096d311e2543ba840c1c435d8e874e318e40bf711533f70"
  end

  depends_on "python@3.9"

  def install
    # Based on name-that-hash
    # https://github.com/Homebrew/homebrew-core/blob/9652b75b2bbaf728f70c50b09cce39520c08321d/Formula/name-that-hash.rb
    virtualenv_install_with_resources

    xy = Language::Python.major_minor_version Formula["python@3.9"].opt_bin/"python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-beartype.pth").write pth_contents
  end

  test do
    # Simple version number check
    system Formula["python@3.9"].opt_bin/"python3", "-c", <<~EOS
      import #{name}
      assert #{name}.__version__ == "#{version}"
    EOS
  end
end
