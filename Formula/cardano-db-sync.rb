class CardanoDbSync < Formula
  desc "A Cardano chain indexer that stores blocks and transactions in a PostgreSQL database"
  homepage "https://github.com/IntersectMBO/cardano-db-sync"
  license "Apache-2.0"

  on_linux do
    on_intel do
      url "https://github.com/IntersectMBO/cardano-db-sync/releases/download/13.8.0.0/cardano-db-sync-13.8.0.0-linux-amd64.tar.gz"
      sha256 "e05754514730bfa626763f9c1e58dff2f9b3e6b2e6a131d238bba69947d65045"
    end

    on_arm do
      url "https://github.com/IntersectMBO/cardano-db-sync/releases/download/13.8.0.0/cardano-db-sync-13.8.0.0-linux-arm64.tar.gz"
      sha256 "0c6d69ff477c78c74fd2ad7d8c55b200276e71ca41681bc5927e84061053d7fa"
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/IntersectMBO/cardano-db-sync/releases/download/13.8.0.0/cardano-db-sync-13.8.0.0-macos-arm64.tar.gz"
      sha256 "681eebc0d3acaebf662eb0b32b2f2eb48293d72f880a2456d0cd94239cd448bd"
    end
  end
  depends_on "cardano-conf"

  def install
    bin.install Dir["bin/{cardano-db-sync,cardano-smash-server}"]
  end

  test do
    assert_predicate bin/"cardano-db-sync", :exist?
    assert_predicate bin/"cardano-smash-server", :exist?
  end
end
