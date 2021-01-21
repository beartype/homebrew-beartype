class Beartype < Formula
  include Language::Python::Virtualenv

  desc "Unbearably fast O(1) runtime type-checking in pure Python"
  homepage "https://github.com/beartype/beartype"
  url "https://files.pythonhosted.org/packages/19/d5/4f6d70a2096ce24ad91b8fabdac28643fdddf920e0f7977cde7bd1bb7296/beartype-0.5.1.tar.gz"
  sha256 "195b1ea1834511b876507563808d8ca602d7cfb141ab9660c17a5148fb38eeb9"
  license "MIT"
  # Default branch is "main" not "master" (unbearably modern)
  head "https://github.com/beartype/beartype.git", branch: "main"

  livecheck do
    url :stable
  end

  bottle do
    root_url "https://github.com/beartype/homebrew-beartype/releases/download/beartype-0.5.1"
    cellar :any_skip_relocation
    sha256 "f544326a5c21a65f9c8dcbb9dcdfa62955c22b80133c45b008b98cfe4638f989" => :big_sur
    sha256 "ba564c174ff0fc1cd436d2383ce636a8a6c6467fccc72d5b8f79335409321f88" => :catalina
    sha256 "0040fbf165a51d4a0fc8c73a90c458d0818693bb4d69b47d23ad893153a8ac38" => :x86_64_linux
  end

  depends_on "python@3.9"

  def install
    system Formula["python@3.9"].opt_bin/"python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    # Simple version number check
    system Formula["python@3.9"].opt_bin/"python3", "-c", <<~EOS
      import #{name}
      assert #{name}.__version__ == "#{version}"
    EOS
  end
end
