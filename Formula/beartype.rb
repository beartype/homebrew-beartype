class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/6b/75/86533c625a7974807b91d7e40e7a3e3b588564b370fc340579e5d6bdbe92/beartype-0.8.1.tar.gz"
  sha256 "c2a2bac961cae7f022d88b892c0d23e91314915aea3e01f316880b4fb00d7d2c"
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
