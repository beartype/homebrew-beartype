class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/ef/16/11a1509d5cd7f3760101edda30f66b28367f2793178bea57745733e92076/beartype-0.9.1.tar.gz"
  sha256 "623630dc243b0da5a84f0fa414e6aaaf2613e567ad19abfe6a81c17ea5ab62f1"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.9.1"
    sha256 cellar: :any_skip_relocation, catalina:     "6d1143a47384158253eb99bc6d7566b545f7a24c3afe17072c9bf0f01b2e2f77"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0525c165036713870a363327fa04a7429e5c0f593c2dbeed576a205e678e6e32"
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
