class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/c7/a8/7154f5dbf53553d244220a2c2736851dd22b60d85e59967a632795c17db6/beartype-0.6.0.tar.gz"
  sha256 "f6167aaa2691db46669f1c2e2aa1f2c38f456fe8a669fe9d3f2af6ed97d083ec"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.6.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "053c2d4334d8c586d6d61bf86acccf62672cc6cf33b98a68a85d793ec9cecdb5"
    sha256 cellar: :any_skip_relocation, catalina:     "2cc2a7e83aab500cad900ff2697685315ed6e92d6ecfda218daecfb4169ee20f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a4832eed8295f039e69b9fc6e5b4bd8e172f2bfb0cc00a5fc3587023560bd67c"
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
