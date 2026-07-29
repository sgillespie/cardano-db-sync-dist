class CardanoDbSyncMainnet < Formula
  desc "Cardano chain indexer that stores blocks/transactions in a PostgreSQL database"
  homepage "https://github.com/IntersectMBO/cardano-db-sync"
  url "https://github.com/IntersectMBO/cardano-db-sync/releases/download/13.7.2.1/cardano-db-sync-13.7.2.1-linux.tar.gz"
  sha256 "e1d94e868e7abcf26d506d921787add698e65ca7d90491d8d4fd7f1af6770bf1"
  license "Apache-2.0"

  depends_on "cardano-conf"
  depends_on "cardano-db-sync"
  depends_on "cardano-node-mainnet"

  def install
    # Write a default PostgreSQL password file to pkgshare
    (pkgshare/"pgpass").write "/tmp:5432:cardano-db-sync-mainnet:*:*"
    # Make a copy so install doesn't clobber the original
    cp pkgshare/"pgpass", "pgpass"
    # Copy it out to etc/
    etc.install "pgpass" => "cardano/mainnet/pgpass"

    # Copy out migrations to pkgshare; it's not meant to be edited by users, so no need
    # to create another copy in etc/.
    pkgshare.install "schema"
  end

  service do
    network = "mainnet"

    # Required by cardano-db-sync at runtime
    environment_variables \
      PGPASSFILE: "#{etc}/cardano/#{network}/pgpass",
      PATH:       "#{formula_opt_bin("postgresql")}:/usr/bin:/bin"

    run [
      formula_opt_bin("cardano-db-sync")/"cardano-db-sync",
      "--config", etc/"cardano/#{network}/db-sync-config.json",
      "--state-dir", var/"cardano-db-sync/#{network}",
      "--socket-path", var/"cardano/#{network}/node.socket",
      "--schema-dir", opt_pkgshare/"schema"
    ]
  end

  def caveats
    <<~EOS
      cardano-db-sync-mainnet requires postgresql and cardano-node-mainnet services. To
      start them now and restart at login:
        brew services start postgresql
        brew services start cardano-node-mainnet
      Or, if you don't want them to restart at login you can just run:
        brew services run postgresql
        brew services run cardano-node-mainnet

      Then create the mainnet database:
        createdb cardano-db-sync-mainnet
    EOS
  end

  test do
    # Should have the correct dependencies
    assert_includes deps.map(&:name), "cardano-conf"
    assert_includes deps.map(&:name), "cardano-node"
    assert_includes deps.map(&:name), "cardano-db-sync"
    # Should have network configs in etc/
    assert_path_exists etc/"cardano/mainnet/config.json"
    # Should have pgpass file
    assert_path_exists etc/"cardano/mainnet/pgpass"
    # Should have migrations
    assert_path_exists pkgshare/"schema"
    # Should select mainnet config
    assert_includes service.run.map(&:to_s), "#{etc}/cardano/mainnet/db-sync-config.json"
  end
end
