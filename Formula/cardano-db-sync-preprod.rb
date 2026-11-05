class CardanoDbSyncPreprod < Formula
  desc "Cardano chain indexer that stores blocks/transactions in a PostgreSQL database"
  homepage "https://github.com/IntersectMBO/cardano-db-sync"
  url "https://github.com/IntersectMBO/cardano-db-sync/releases/download/13.8.0.0/cardano-db-sync-13.8.0.0-linux-amd64.tar.gz"
  sha256 "e05754514730bfa626763f9c1e58dff2f9b3e6b2e6a131d238bba69947d65045"
  license "Apache-2.0"

  depends_on "cardano-conf"
  depends_on "cardano-db-sync"
  depends_on "cardano-node-preprod"

  def install
    # Write a default PostgreSQL password file to pkgshare
    (pkgshare/"pgpass").write "/tmp:5432:cardano-db-sync-preprod:*:*"
    # Make a copy so install doesn't clobber the original
    cp pkgshare/"pgpass", "pgpass"
    # Copy it out to etc/
    etc.install "pgpass" => "cardano/preprod/pgpass"

    # Copy out migrations to pkgshare; it's not meant to be edited by users, so no need
    # to create another copy in etc/.
    pkgshare.install "schema"
  end

  service do
    network = "preprod"

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
      cardano-db-sync-preprod requires postgresql and cardano-node-preprod services. To
      start them now and restart at login:
        brew services start postgresql
        brew services start cardano-node-preprod
      Or, if you don't want them to restart at login you can just run:
        brew services run postgresql
        brew services run cardano-node-preprod

      Then create the preprod database:
        createdb cardano-db-sync-preprod
    EOS
  end

  test do
    # Should have the correct dependencies
    assert_includes deps.map(&:name), "cardano-conf"
    assert_includes deps.map(&:name), "cardano-node"
    assert_includes deps.map(&:name), "cardano-db-sync"
    # Should have network configs in etc/
    assert_path_exists etc/"cardano/preprod/config.json"
    # Should have pgpass file
    assert_path_exists etc/"cardano/preprod/pgpass"
    # Should have migrations
    assert_path_exists pkgshare/"schema"
    # Should select preprod config
    assert_includes service.run.map(&:to_s), "#{etc}/cardano/preprod/db-sync-config.json"
  end
end
