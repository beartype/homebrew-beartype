class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/5b/3e/b230c6cb4b0391591f7949d8fd55bb43aa9128465caa5a930f9398b447ad/beartype-0.16.4.tar.gz"
  sha256 "1ada89cf2d6eb30eb6e156eed2eb5493357782937910d74380918e53c2eae0bf"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.16.3"
    sha256 cellar: :any_skip_relocation, ventura:      "f460ab41a2e2cda985b7ad810fa4aba5f4db9437e949bf70d6a646c9a5ac4156"
    sha256 cellar: :any_skip_relocation, monterey:     "5065b8df2948b34ac4d8d201d90f4e295bafe826f83237dc6af6820b2d03e446"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ad2cb7431c1c633eadf0a48d74ef6ce3185474073eb3f66d2d03d572b4b7edd7"
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
