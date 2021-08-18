class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/40/5c/06005933be7c74bd03c115a9dc8e36ca1a004a76b12b5040759fc20d9f99/beartype-0.8.0.tar.gz"
  sha256 "d6038f631b7e3d9dba18c9a3f18282af505fc2076003dd51b61abbcbdafaa859"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.7.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "d196e40751fd4ef1a69d1293689db136bad54ebc5bfbe42874d029d50bc0a4c3"
    sha256 cellar: :any_skip_relocation, catalina:     "fcd6a805f03dba774f88b6f74c037eb1bff502b554c91b1bf983067a757cafa6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5f86683730d8970bbdf609b1799642a6fa358018dd8efdd853b9755f16bcfd17"
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
