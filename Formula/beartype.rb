class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/89/3b/9ecfc75d1f8bb75cbdc87fcb3df7c6ec4bc8f7481cb7102859ade1736c9d/beartype-0.14.1.tar.gz"
  sha256 "23df4715d19cebb2ce60e53c3cf44cd925843f00c71938222d777ea6332de3cb"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.14.1"
    sha256 cellar: :any_skip_relocation, ventura:      "7d5aec866e00800f5c8d33a4c860e9f42dd292bf346ed7e13f3a8d6cd18f69c7"
    sha256 cellar: :any_skip_relocation, monterey:     "fcef7c1f609b9cd3a8774e41fbcf82d0bb0c243aec6f12b0868502c3f468d4b1"
    sha256 cellar: :any_skip_relocation, big_sur:      "8e26063ea213c975b6d8ee43f1ea160f5c6387ef373b986000152e8ed6522789"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "311c7698a6dbd6a3e3ecc6698fe654048ff64a59365000dc015b440371a9c990"
  end

  depends_on "python@3.11"

  def install
    # Based on name-that-hash
    # https://github.com/Homebrew/homebrew-core/blob/9652b75b2bbaf728f70c50b09cce39520c08321d/Formula/name-that-hash.rb
    virtualenv_install_with_resources

    xy = Language::Python.major_minor_version Formula["python@3.11"].opt_bin/"python3"
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-beartype.pth").write pth_contents
  end

  test do
    # Simple version number check
    system Formula["python@3.11"].opt_bin/"python3.11", "-c", <<~EOS
      import #{name}
      assert #{name}.__version__ == "#{version}"
    EOS
  end
end
