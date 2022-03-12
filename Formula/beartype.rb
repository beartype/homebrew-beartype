class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/e9/b3/9afd125fba938526100c75f29512713e031cc1ce21d443aac4707f55279c/beartype-0.10.3.tar.gz"
  sha256 "5ca1bb66dd9647155bfdb82ca1a066663f7743f2bc87f60004addf739def8236"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.10.2"
    sha256 cellar: :any_skip_relocation, catalina:     "f6ea99c3516b48145016129bc6b6f9fdfa122db69e10f26375dace5e6032e991"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b0aed47a037fad315fa19e471d8ce8cff055471c1ebb60707b3bca814af1a7d"
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
