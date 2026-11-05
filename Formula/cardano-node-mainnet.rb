class CardanoNodeMainnet < Formula
  desc "The core component that is used to participate in a Cardano decentralised blockchain (mainnet package)."
  homepage "https://github.com/IntersectMBO/cardano-node"
  url "https://github.com/IntersectMBO/cardano-node/releases/download/11.1.3/cardano-node-11.1.3-linux-amd64.tar.gz"
  sha256 "530fb99986fbdccc46f9ee0dd86cabb1393b015feac9173cb731d89fa748365f"
  license "Apache-2.0"
  version "11.1.3"

  depends_on "cardano-conf"
  depends_on "cardano-node"

  def install
    # A service-only formula is seen as an empty installation, so write an empty dummy
    # file into pkgshare
    mkdir pkgshare
    touch pkgshare/".install_placeholder"
  end

  service do
    network = "mainnet"

    run [
      Formula["cardano-node"].opt_bin/"cardano-node",
      "run",
      "--config", etc/"cardano/#{network}/config.json",
      "--topology", etc/"cardano/#{network}/topology.json",
      "--database-path", var/"cardano/#{network}/db",
      "--socket-path", var/"cardano/#{network}/node.socket",
      "--host-addr", "0.0.0.0",
      "--port", "3001"
    ]

    keep_alive crashed: true
  end

  test do
    # Should have the correct dependencies
    assert_includes deps.map(&:name), "cardano-conf"
    assert_includes deps.map(&:name), "cardano-node"
    # Should have network configs in etc
    assert_predicate etc/"cardano/mainnet/config.json", :exist?
    # Should select mainnet config
    assert_includes service.run.map(&:to_s), "#{etc}/cardano/mainnet/config.json"
  end
end
