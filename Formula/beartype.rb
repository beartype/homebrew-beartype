class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/c9/ee/f6eed95460062c9751aabe6cc279510cecc9492a04f274a14b52812534fd/beartype-0.7.1.tar.gz"
  sha256 "0ea3b0b7983e4bdabb47ad299a4ba11cc48beaedabaf89752eea27cb6152e5c1"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.7.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "a618db31705210dafca1ed59948313dc54cd59786cf1451780e537b359c665a5"
    sha256 cellar: :any_skip_relocation, catalina:     "51e99b7e22c0e191f3b6f34ce2b3b1bfb2ff14e42476eac3263fcef8e1325508"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "66fda38da16a3a9129547f828c010b48b9db2d936d25217f8c522587934e4f72"
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
