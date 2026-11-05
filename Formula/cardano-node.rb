class CardanoNode < Formula
  desc "The core component that is used to participate in a Cardano decentralised blockchain."
  homepage "https://github.com/IntersectMBO/cardano-node"
  license "Apache-2.0"
  version "11.1.3"

  on_linux do
    on_intel do
      url "https://github.com/IntersectMBO/cardano-node/releases/download/11.1.3/cardano-node-11.1.3-linux-amd64.tar.gz"
      sha256 "530fb99986fbdccc46f9ee0dd86cabb1393b015feac9173cb731d89fa748365f"
    end

    on_arm do
      url "https://github.com/IntersectMBO/cardano-node/releases/download/11.1.3/cardano-node-11.1.3-linux-arm64.tar.gz"
      sha256 "3b638c87448bf08d3680f9116ca92e876579b865c0540f8f33b5c586a02ebf8a"
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/IntersectMBO/cardano-node/releases/download/11.1.3/cardano-node-11.1.3-linux-arm64.tar.gz"
      sha256 "8c3162031d63838709a5d59117130ddf8059b3456a367ea374b054cf2161a960"
    end
  end

  depends_on "cardano-conf"

  def install
    bin.install Dir["bin/*"]
  end

  test do
    assert_predicate bin/"cardano-cli", :exist?
    assert_predicate bin/"cardano-node", :exist?
  end
end
