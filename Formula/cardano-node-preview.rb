class CardanoNodePreview < Formula
  desc "The core component that is used to participate in a Cardano decentralised blockchain (preview package)."
  homepage "https://github.com/IntersectMBO/cardano-node"
  url "https://github.com/IntersectMBO/cardano-node/releases/download/11.0.1/cardano-node-11.0.1-linux-amd64.tar.gz"
  sha256 "40e88a543564251338c4888ef79fde51d2306c18b48ac308c9eab3220e3a13f0"
  license "Apache-2.0"
  version "11.0.1"

  depends_on "cardano-conf"
  depends_on "cardano-node"

  def install
    # A service-only formula is seen as an empty installation, so write an empty dummy
    # file into pkgshare
    mkdir pkgshare
    touch pkgshare/".install_placeholder"
  end

  service do
    network = "preview"

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
    assert_predicate etc/"cardano/preview/config.json", :exist?
    # Should select preview config
    assert_includes service.run.map(&:to_s), "#{etc}/cardano/preview/config.json"
  end
end
