class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/19/d5/4f6d70a2096ce24ad91b8fabdac28643fdddf920e0f7977cde7bd1bb7296/beartype-0.5.1.tar.gz"
  sha256 "195b1ea1834511b876507563808d8ca602d7cfb141ab9660c17a5148fb38eeb9"
  license "MIT"
  revision 1
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
