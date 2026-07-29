class CardanoDbSync < Formula
  desc "A Cardano chain indexer that stores blocks and transactions in a PostgreSQL database"
  homepage "https://github.com/IntersectMBO/cardano-db-sync"
  url "https://github.com/IntersectMBO/cardano-db-sync/releases/download/13.7.2.1/cardano-db-sync-13.7.2.1-linux.tar.gz"
  sha256 "e1d94e868e7abcf26d506d921787add698e65ca7d90491d8d4fd7f1af6770bf1"
  license "Apache-2.0"

  depends_on "cardano-conf"

  def install
    bin.install Dir["bin/{cardano-db-sync,cardano-smash-server}"]
  end

  test do
    assert_predicate bin/"cardano-db-sync", :exist?
    assert_predicate bin/"cardano-smash-server", :exist?
  end
end
