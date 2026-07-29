class CardanoNode < Formula
  desc "The core component that is used to participate in a Cardano decentralised blockchain."
  homepage "https://github.com/IntersectMBO/cardano-node"
  url "https://github.com/IntersectMBO/cardano-node/releases/download/11.0.1/cardano-node-11.0.1-linux-amd64.tar.gz"
  sha256 "40e88a543564251338c4888ef79fde51d2306c18b48ac308c9eab3220e3a13f0"
  license "Apache-2.0"
  version "11.0.1"

  depends_on "cardano-conf"

  def install
    bin.install Dir["bin/*"]
  end

  test do
    assert_predicate bin/"cardano-cli", :exist?
    assert_predicate bin/"cardano-node", :exist?
  end
end
