class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/44/53/d6c12499cf368ce34e930cc7ec6afda63279b39deb199f306b62e720432b/beartype-0.10.2.tar.gz"
  sha256 "2e8d405318fe411ecdd937627f9f33181312a793ebd239b3da769c4439cb4b98"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.10.1"
    sha256 cellar: :any_skip_relocation, catalina:     "5b893b3d9136cfe1371286d83670d4fc105a72740e799089c363a79e82048c56"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a2448e827787cf156d3f726e747ecabf69caa2cbd33e90d1239cb37ba5c37060"
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
