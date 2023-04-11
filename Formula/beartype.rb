class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/ec/91/067ba8e805db88b8260308609959b5e124f01cebdb5346f147887a78dca0/beartype-0.13.1.tar.gz"
  sha256 "2903947a8a1eb6030264e30108aa72cb1a805cfc9050c0f4014c4aed3a17a00b"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.13.1"
    sha256 cellar: :any_skip_relocation, monterey:     "979e6d48e39952d278a4b3a946fd4fa02ee1c901430e6cad643f41b24a46f480"
    sha256 cellar: :any_skip_relocation, big_sur:      "ede29f273b44889b0587ecb25d78d918da53a29cf97911a7e6a34f9c53a80746"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f31800a7b96b7f7c7b46fb5ca3a8cf73462dfa652beb2c5fa9c7a6ad83e705b9"
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
