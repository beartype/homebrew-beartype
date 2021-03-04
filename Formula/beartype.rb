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
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.5.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "f544326a5c21a65f9c8dcbb9dcdfa62955c22b80133c45b008b98cfe4638f989"
    sha256 cellar: :any_skip_relocation, catalina:     "ba564c174ff0fc1cd436d2383ce636a8a6c6467fccc72d5b8f79335409321f88"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0040fbf165a51d4a0fc8c73a90c458d0818693bb4d69b47d23ad893153a8ac38"
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
