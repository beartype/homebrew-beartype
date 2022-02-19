class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/85/0c/06778a7b2f586f8bd061204ac514807f4f96b6b74ae3a359ed9ebc54f66c/beartype-0.10.1.tar.gz"
  sha256 "ef228e66938b4f4487d8b306a1d19a0938bc4ef244b6162309f423ccc8cefc76"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.10.0"
    sha256 cellar: :any_skip_relocation, catalina:     "ae61aa59139cec2db83dcf02ebf6a954dfd3651a6e4a3c37462445368174c218"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "767b0d499a58a8e2dfa4ead369cdc6c7e77d22782ee76983a95acf08643cf490"
  end

  depends_on "python@3.10"

  def install
    # Based on name-that-hash
    # https://github.com/Homebrew/homebrew-core/blob/9652b75b2bbaf728f70c50b09cce39520c08321d/Formula/name-that-hash.rb
    virtualenv_install_with_resources

    xy = Language::Python.major_minor_version Formula["python@3.10"].opt_bin/"python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-beartype.pth").write pth_contents
  end

  test do
    # Simple version number check
    system Formula["python@3.10"].opt_bin/"python3", "-c", <<~EOS
      import #{name}
      assert #{name}.__version__ == "#{version}"
    EOS
  end
end
